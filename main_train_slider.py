import time
import datetime
import torch
#from torch.autograd import Variable
import torch.optim as optim
import numpy as np
import source.dbsearch as dbsearch
import source.models as models
import source.parameters as params
import source.utils as utils
import copy
import matplotlib as mpl

torch.set_num_threads(4)
torch_type = params.types['float_type']

PATH = './'

log_softmax = torch.nn.LogSoftmax(dim=0)

def Info(text, end='\n', flush=True, show=True):
    if show:
        print(text, end=end, flush=flush)

def main(parameters=None):
    
    # memory_limit()
    if GPU_ID == "-1":
        torch_device = torch.device("cpu")
    else:
        torch_device = torch.device("cuda:{}".format(GPU_ID) if torch.cuda.is_available() else "cpu")

    if parameters is None:
        training_parameters = params.training
    else:
        training_parameters = parameters

    filename_stem = '{}/{}-{}'.format(PATH + 'results', DATASET, RES)

    param_string = params.params_to_string(training_parameters)

    filename = '{}-{}'.format(filename_stem, param_string)

    total_time = time.time()
    today = datetime.date.today()
    # writer = SummaryWriter(log_dir=PATH+"logs/%s-%s"%(today,DATASET))
    result = open('result_cross_entropy.txt','a')
    result.write("DATASET: " + DATASET + '\n')
    result.write("RES: " + RES + '\n')
    print('XENT', DATASET, RES)
    param_string = params.params_to_string(training_parameters)
    dbs = dbsearch.DBSearch(
        bin_width=params.dbsearch[RES]['bin_width'],
        bin_offset=params.dbsearch[RES]['bin_offset'],
        tolarence_window=params.spectrum[DATASET]['tolarence_window'],
        tolarence_type=params.spectrum[DATASET]['tolarence_type'],
        remove_precursor_peak=params.dbsearch['remove_precursor_peak'],
        enzyme=params.spectrum[DATASET]['enzyme'],
        missed_cleavages=params.spectrum[DATASET]['missed_cleavages'],
        decoy_format=params.dbsearch['decoy_format'],
        max_theo_pept_peak_charge=params.dbsearch['max_theo_pept_peak_charge'],
        min_pept_len=params.dbsearch['min_pept_len'],        
        max_mods=params.spectrum[DATASET]['max_mods'],
        max_peak=params.dbsearch['max_peak'],
        modifications=params.spectrum[DATASET]['modifications'],
        static_mods=params.spectrum[DATASET]['static_mods'])
    dbs.max_intensity = params.dbsearch['max_intensity']
    target_from_theo_pept = training_parameters['target_from_theo_pept']
    print_info = training_parameters['print_info']
    printing_tick = training_parameters['printing_tick']
    topN = training_parameters['topN']

    Info("Loading and preprocessing spectra...", end='', flush=True, show=print_info)
    start_time = time.time()

   
    dbs.load_mgf_data(params.spectrum[DATASET]['ms_data_file'])

    utils.spectrum_normalization(dbs)
    dbs.sort_spectra()
    Info("Done. Time: {} sec.".format(round(time.time()-start_time, 2)), show=print_info)

    Info("Loading protein sequences and generating peptides for testing...", show=print_info)
    start_time = time.time()
    utils.load_peptides(dbsearch=dbs, fasta=params.spectrum[DATASET]['fasta_file'])
    Info("Generate theoreticals peaks...", show=print_info)
    utils.generate_unique_theoretical_peaks(dbs)    
    Info("Number of proteins:\t%d"%(len(dbs.protein_collection)), show=print_info)
    Info("Number of spectra:\t%d"%(len(dbs.spectrum_collection)), show=print_info)
    Info("Number of peptides:\t%d"%(len(dbs.peptide_collection)), show=print_info)
    Info("Done. Time: {} sec.".format(round(time.time()-start_time, 2)), show=print_info)

    PSMs_scalar = []
    PSMs_mean_norm_scalar = []
    PSMs_xcorr = []

    id = dbs.get_spectrum_idx(dbs.spectrum_collection[0].id)
        
    Info("Running XCorr scoring...", end='\n', flush=True, show=print_info)
    start_time = time.time()
    utils.spectrum_normalization(dbs, N=topN)
    utils.run_tailor_search(dbsearch=dbs, filename=filename+'-tailor_baseline.dbsearch')
    Info("Done. Time: {} sec.".format(round(time.time()-start_time, 2)), show=print_info)
    PSMs_xcorr.append(dbs.print_accepted_psms())

    spectrum_xcorr = copy.deepcopy(dbs.spectrum_collection[id])
    if print_info:
        dbs.plot_spectrum(id, filename='{}-{}_xcorr_{}'.format(filename[:30], DATASET, id), show_annotation=True)
        pep_id, pep_scan_id = dbs.spectrum_collection[id].id, dbs.spectrum_collection[id].scan_id
    
    
    window_width = int(training_parameters['window_width']/params.dbsearch[RES]['bin_width'])
    nEpochs = training_parameters['epochs']
    batch_size = training_parameters['batch_size']
    kernel_num = training_parameters['kernel_num']
    clip_value = training_parameters['clip_value']
    
    spectrum_size = dbs.max_bin

    conv_net = models.DeepConv(window_width=window_width, kernel_num=kernel_num, spectrum_size=spectrum_size, torch_device=torch_device, torch_type=torch_type)
    conv_net = conv_net.to(torch_device)
    weight_level = 1

    optimizer = optim.Adam(filter(lambda p: p.requires_grad, conv_net.parameters()),
        lr=training_parameters['learning_rate'],
        weight_decay=0)

    

    xent = models.BCELossWeight(pos_weight=torch.tensor(params.spectrum[DATASET]['pos_weight'], dtype=torch.float, device=torch_device))

    Info("Training filter parameters...", end='\n', flush=True, show=print_info)
    utils.spectrum_discretization(dbs)
    start_time = time.time()
    learning_curve = []
    
    for epoch in range(nEpochs):
        partial_loss = 0
        batch_cnt = 0

        for batch_idx in dbs.spectrum_batch_generator(batch_size, shuffle=False):
            spectrum_batch = torch.stack(list(torch.from_numpy(dbs.spectrum_collection[i].spectrum_array).float().view(1, -1) for i in batch_idx))
            target = (spectrum_batch > 0).float()
            
            if target_from_theo_pept >= 0:
                for spect_cnt, spect_id in enumerate(batch_idx):
                    if dbs.spectrum_collection[spect_id].qvalue < target_from_theo_pept:
                        peak_list = dbs.spectrum_collection[spect_id].peptide.unique_peaks
                        target[spect_cnt, 0,  :] = 0
                        target[spect_cnt, 0, peak_list] = 1
                    else:
                        target[spect_cnt, 0, :] = 0
                        spectrum_batch[spect_cnt, :] = 0
            else:
                candidate_batch = torch.stack(list(torch.from_numpy(candidate_spectra[i].spectrum_array).float().view(1, -1) for i in batch_idx))
                target = (candidate_batch > 0).float()

            if dbs.spectrum_collection[batch_idx[0]].qvalue > target_from_theo_pept and target_from_theo_pept >= 0:
                break
               
            spectrum_batch = spectrum_batch.to(torch_device)
            target = target.to(torch_device)
            output = conv_net(spectrum_batch)
            loss = xent(output, target)
            loss.backward()
            
            conv_net.clip_grads(clip_value=clip_value)
            optimizer.step()
            optimizer.zero_grad()
            partial_loss += loss
            batch_cnt += 1
        epoch_error = (partial_loss/batch_cnt).data.cpu().numpy()
        # conv_net.update_log(writer, epoch_error, epoch)

        learning_curve.append(epoch_error)
        if (epoch+1)%printing_tick == 0 or epoch == 0:
            print("Epoch: {}/{}. Time: {}, loss:{}".format(epoch+1, nEpochs, round(time.time()-start_time, 2), epoch_error))

    Info("Learning done. Time: {} sec.".format(round(time.time()-start_time, 2)), show=print_info)

    utils.spectrum_discretization(dbs)
    utils.spectrum_transformation(dbsearch=dbs, model=conv_net, torch_device=torch_device)
    utils.run_tide(dbsearch=dbs, filename=filename_stem+'-transformed.dbsearch')
    PSMs_transf = dbs.print_accepted_psms()

    pr = str('Number of accepted PSMs at 0.1%% FDR = %d,\t1%% FDR = %d,\t5%% FDR = %d,\t10%% FDR = %d'%PSMs_transf)
    result.write(pr + '\n')
    if print_info:
        for new_id, s in enumerate(dbs.spectrum_collection):
            if s.id == pep_id and s.scan_id == pep_scan_id:
                id = new_id
                break
        dbs.plot_spectrum(id, filename='{}-{}_transformed_XENT_{}'.format(filename[:30], DATASET, id), show_annotation=True)
        utils.plot_learning_curve(learning_curve=learning_curve, filename_stem=filename_stem)

    spectrum_trans = copy.deepcopy(dbs.spectrum_collection[id])

    utils.run_tailor_search(dbsearch=dbs, filename=filename_stem+'-mean_norm_transformed.dbsearch')
    PSMs_mean_norm_transf = dbs.print_accepted_psms()
    pr = str('Number of accepted PSMs at 0.1%% FDR = %d,\t1%% FDR = %d,\t5%% FDR = %d,\t10%% FDR = %d'%PSMs_mean_norm_transf)
    result.write(pr + '\n')
    dbs.export_spectra_ms2('{}_filtered_{}_xent.ms2'.format(filename_stem, training_parameters['window_width']))        

    utils.spectrum_substract_background(dbs)
    utils.run_tide(dbsearch=dbs, filename=filename_stem+'-xcorr_transformed.dbsearch')
    PSMs_xcorr_transf = dbs.print_accepted_psms()
    pr = str('Number of accepted PSMs at 0.1%% FDR = %d,\t1%% FDR = %d,\t5%% FDR = %d,\t10%% FDR = %d'%PSMs_xcorr_transf)
    result.write(pr + '\n')

    utils.run_tailor_search(dbsearch=dbs, filename=filename_stem+'-tailor_transformed.dbsearch')
    PSMs_tailor_transf = dbs.print_accepted_psms()
    pr = str('Number of accepted PSMs at 0.1%% FDR = %d,\t1%% FDR = %d,\t5%% FDR = %d,\t10%% FDR = %d'%PSMs_tailor_transf)
    result.write(pr + '\n')

    Info("Total  time: {} sec".format(round(time.time()-total_time, 2)), show=print_info)

    result.flush()
    mpl.pyplot.close('all')
    return filename


