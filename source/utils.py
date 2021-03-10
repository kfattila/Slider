import os.path
import numpy as np
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt      
import torch
from torch.autograd import Variable
from source.parameters import types 

top_activation_fnc = torch.nn.Sigmoid()


dtype = types['dtype']
torch_device = types['torch_device']
float_type = types['float_type']

def spectrum_normalization(dbsearch, N=100):
    for spectrum_id in range(len(dbsearch.spectrum_collection)):
        dbsearch.discretize_spectrum(spectrum_id)
        dbsearch.normalize_regions(spectrum_id, N)
        # dbsearch.topN(spectrum_id, N=N)

def add_aux_peaks(dbsearch, peak_type):
    #print("auxiliary_peak_type%d"%(peak_type))
    if peak_type == 0:
        return
    for spectrum_id in range(len(dbsearch.spectrum_collection)):
        dbsearch.add_auxiliary_peaks(spectrum_id, peak_type)

def spectrum_substract_background(dbsearch):
    for spectrum_id in range(len(dbsearch.spectrum_collection)):
        dbsearch.XCORR_substract_background(spectrum_id)

def spectrum_transformation(dbsearch, model, torch_device=None):
    center_weight = 1
    cutoff_coeff = 0.0
    #model.filter_center = torch.nn.Parameter(torch.from_numpy(center_weight*np.ones(model.filter_center.size()[0])).float().cuda())
 
    for spectrum in dbsearch.spectrum_collection:
        # new_spectrum_array = top_activation_fnc(model(torch.from_numpy(spectrum.spectrum_array).float().view(1, 1, -1).cuda())).data.cpu().numpy().ravel()
        
        new_spectrum_array = model(torch.from_numpy(spectrum.spectrum_array).float().view(1, 1, -1).to(torch_device)).data.cpu().numpy().ravel()
        # if peaks_only:
        # new_spectrum_array[spectrum.spectrum_array == 0] = 0
        # new_spectrum_array -= new_spectrum_array.min()
        # spectrum.spectrum_array = mixing_ratio*spectrum.spectrum_array + (1-mixing_ratio)*new_spectrum_array
        # spectrum.spectrum_array += 5*(new_spectrum_array-0.5)
        spectrum.spectrum_array = new_spectrum_array
        # spectrum.spectrum_array[spectrum.spectrum_array <= 0] = 0
        # spectrum.spectrum_array[spectrum.spectrum_array < cutoff_coeff*spectrum.spectrum_array.max()] = 0
        # spectrum.spectrum_array = new_spectrum_array


def run_tide(dbsearch, filename):
    dbsearch.reset_search_results()
    dbsearch.sort_spectra()
    dbsearch.tide_search()
    dbsearch.compute_qvalues_tdc()
#     dbsearch.print_results(filename)
#     dbsearch.print_accepted_psms()

def run_mean_norm_search(dbsearch, filename):
    dbsearch.reset_search_results()
    dbsearch.sort_spectra()
    dbsearch.tailor_scoring()
    dbsearch.compute_qvalues_tdc()
    #dbsearch.print_results(filename)

def run_tailor_search(dbsearch, filename):
    dbsearch.reset_search_results()
    dbsearch.sort_spectra()
    dbsearch.tailor_scoring()
    dbsearch.compute_qvalues_tdc()
    #dbsearch.print_results(filename)

def run_baseline(dbsearch, filename):
    if os.path.isfile(filename) == False: #If baseline results do not exist, calculate them
        # spectrum_substract_background(dbsearch)
        run_tide(dbsearch, filename)

def load_peptides(dbsearch, fasta):
    dbsearch.load_fasta(fasta)    
    for i in range(len(dbsearch.protein_collection)):
        dbsearch.generate_peptides(i)
    dbsearch.sort_peptides()
    dbsearch.sort_spectra()
    dbsearch.set_candidate_peptides()    


def plot_masses(ax, masses, annotate=True):
    annotation_y = ax.get_ylim()[0]-(ax.get_ylim()[1] - ax.get_ylim()[0])/10
    cmap = plt.cm.get_cmap('nipy_spectral', len(masses.index))
    for m in masses[(ax.get_xlim()[0] <= masses) & (masses <= ax.get_xlim()[1])].sort_values().index:
        loc = masses.sort_values().index.get_loc(m)
        ax.axvline(masses[m], c=cmap(loc), alpha=0.5, linewidth=5.0)
        if annotate:
            ax.annotate(str(m)+" ("+str(masses[m])+")",
            size=16,
            xy=(masses[m],0), xycoords='data',
            xytext=(ax.get_xlim()[0], annotation_y), textcoords='data',
            arrowprops=dict(arrowstyle="-",
                            color=cmap(loc),
                            lw=3.5,
                            alpha=0.5,
                            connectionstyle="angle,angleA=0,angleB=90,rad=10"))
            annotation_y -= (ax.get_ylim()[1] - ax.get_ylim()[0])/22

def plot_weights(model, dbsearch, filename_stem, kernel=0, weight_level=1):

    fig=plt.figure(figsize=(20,30))
    cmap = plt.rcParams['axes.prop_cycle'].by_key()['color']
    #print("kernel_num:\t %d\n"%(kernel))

    # Get amino acid masses
    masses = pd.read_csv("c:\\Users\\User\\YandexDisk\\peak_filter_learning\\masses.txt",sep="\t")["mono mass"]
    discretized_masses = dbsearch.mass2bin_vec(masses)
    offset = 0
    # Get model weights
    weightsc = model.filter_center[kernel].data.cpu().numpy()
    if len(model.filter_pre.size()) > 1:
        # weights1 = np.flip(torch.mean(model.filter_pre, dim=0).data.cpu().numpy(),0)
        # weights2 = torch.mean(model.filter_post, dim=0).data.cpu().numpy()
        weights1 = np.flip(model.filter_pre[kernel,:].data.cpu().numpy(),0)
        weights2 = model.filter_post[kernel,:].data.cpu().numpy()
    else:
        weights1 = np.flip(model.filter_pre.data.cpu().numpy(),0)
        weights2 = model.filter_post.data.cpu().numpy()
    if weight_level == 2:
        weights1 = np.flip(model.filter_pre_second.data.cpu().numpy(),0)
        weights2 = model.filter_post_second.data.cpu().numpy()
        offset = 50


    # Pre_weights
    ax1 = plt.subplot(311)
    # a = np.arange(0, len(weights1)+1)+offset
    # print(a.shape)
    # print(weightsc.shape)
    # print(weights1.shape)    
    # b = np.concatenate((weightsc, weights1))
    # print(b.shape)

    ax1.bar(np.arange(0, len(weights1)+1)+offset,np.concatenate((weightsc, weights1)), color=cmap[0], edgecolor=cmap[0] ) 
    ax1.set_title('Right side weights',fontdict={'fontsize':16},loc='left')
    plot_masses(ax1,discretized_masses,False)

    # Post_weights
    ax2 = plt.subplot(312)
    ax2.bar(np.arange(1, len(weights2)+1)+offset,weights2, color=cmap[0], edgecolor=cmap[0] ) 
    ax2.set_title('Left side weights',fontdict={'fontsize':16},loc='left')
    plot_masses(ax2,discretized_masses,False)

    #
    weights3 = weights1 + weights2
    ax3 = plt.subplot(313)
    ax3.bar(np.arange(1,len(weights3)+1)+offset,weights3, color=cmap[0], edgecolor=cmap[0] ) 
    ax3.set_title('Sum of weights',fontdict={'fontsize':16},loc='left')
    plot_masses(ax3,discretized_masses)
    fig.savefig(filename_stem+'.weight.png')
    plt.show()
#     plt.clf()  
#     plt.close()

def plot_learning_curve(learning_curve, filename_stem):
    fg=plt.figure(figsize=(10,5))
    fg.patch.set_facecolor('xkcd:white')
    sns.set(style="whitegrid")
    data = pd.DataFrame(learning_curve, columns=["Learning Curve"])
    data.to_csv(path_or_buf=filename_stem+".learning_curve")
    sns_plot = sns.lineplot(data=data, linewidth=2.5)
    sns_plot.figure.savefig(filename_stem+'.lc.png')

def spectrum_scatter_plot(spectrum1, spectrum2, label_x, label_y, font_size=24): 
    fg=plt.figure(figsize=(10,10))
    fg.patch.set_facecolor('xkcd:white')
    plt.rc('font', size=font_size)          # controls default text sizes
    plt.rc('axes', titlesize=font_size)     # fontsize of the axes title
    plt.rc('axes', labelsize=font_size)     # fontsize of the x and y labels
    plt.rc('xtick', labelsize=font_size)    # fontsize of the tick labels
    plt.rc('ytick', labelsize=font_size)    # fontsize of the tick labels
    plt.rc('legend', fontsize=font_size)    # legend fontsize
    plt.rc('figure', titlesize=font_size)   # fontsize of the figure title
    cmap = plt.rcParams['axes.prop_cycle'].by_key()['color']
    line_width = 2
    bar_width = 0.5
    min_x = np.min((np.min(spectrum1.spectrum_array), np.min(spectrum2.spectrum_array)))
    max_x = np.max((np.max(spectrum1.spectrum_array), np.max(spectrum2.spectrum_array)))
    plt.xlim(min_x, max_x)
    plt.ylim(min_x, max_x)
    
    # Plot diagonal
    plt.plot([min_x, max_x],[min_x,max_x], linewidth=1, color='black')
    # Plot peak intesnities
    plt.scatter(spectrum1.spectrum_array, spectrum2.spectrum_array, color=cmap[0], s=1)

    plt.xlabel(label_x+'-scan id: {}'.format(spectrum1.scan_id))
    plt.ylabel(label_y+'-scan id: {}'.format(spectrum2.scan_id))

    cnt = 1
    for charge in range(len(spectrum1.peptide.peaks)):
    # Use theoretical peaks which were used in scoring
        if spectrum1.charge < 3 and charge > 0:
            continue
        for ion_type in spectrum1.peptide.peaks[charge].keys():
            peaks1 = np.asarray(spectrum1.peptide.peaks[charge][ion_type], dtype=np.int32)
            peaks2 = np.asarray(spectrum1.peptide.peaks[charge][ion_type], dtype=np.int32)
            peaks1 = spectrum1.spectrum_array[peaks1]
            peaks2 = spectrum2.spectrum_array[peaks2]

            plt.scatter(peaks1, peaks2, color=cmap[cnt], s=10)
            cnt += 1
        
def generate_unique_theoretical_peaks(dbsearch):
    # Generate theoretical spectra
    for peptide_id in range(len(dbsearch.peptide_collection)):
        dbsearch.calculate_peptide_fragmentation(peptide_id)
        peaks_b_0 = np.asarray(dbsearch.peptide_collection[peptide_id].peaks[0]['b'], dtype=np.int32)
        peaks_y_0 = np.asarray(dbsearch.peptide_collection[peptide_id].peaks[0]['y'], dtype=np.int32)
        # peaks_b_1 = np.asarray(dbsearch.peptide_collection[peptide_id].peaks[1]['b'], dtype=np.int16)
        # peaks_y_1 = np.asarray(dbsearch.peptide_collection[peptide_id].peaks[1]['y'], dtype=np.int16)
        # peak_list = np.union1d(np.union1d(peaks_b_0, peaks_y_0), np.union1d(peaks_b_1, peaks_y_1))#-dbsearch.spectrum_margin   
        peak_list = np.union1d(peaks_b_0, peaks_y_0)
        #indices = np.where(peak_list >= 0)
        dbsearch.peptide_collection[peptide_id].unique_peaks = peak_list#[indices]

    #print("Theoretical peptide collection was successfully generated. Time elapsed: ", process_timedelta(datetime.now()-startTime), logfile)

def spectrum_discretization(dbsearch):
    for spectrum_id in range(len(dbsearch.spectrum_collection)):
        dbsearch.discretize_spectrum(spectrum_id)
        
def prepare_batch_data(dbs, batch_idx, cand_from_search_qval=-1, min_candidates=0, topN_exp=0, torch_device=None):
    """
    Preparing single batch for training RBM
    
    Parameters
    ----------
    dbs: Object of class DBSearch() with predefined biological parameters
    batch_idx: subsample of spectra indices from experimental data
    cand_from_search_qval: q-value threshold for candidate peptides
    min_candidates: minimum number of theoretical spectra candidates for each experimental spectrum
    topN_exp: value for N most intense peaks to keep from raw spectrum
    
    Returns
    -------
    experimental_spectra: array of experimental spectra
    candidate_spectra: array of candidate spectra
    theoretical_spectra:list of theoretical spectra joined into one matrix corresponding to one experimental spectrum
    """
    batch_size = len(batch_idx)
    dim = int(dbs.max_bin)

    experimental_spectra = np.zeros((batch_size, dim))
    candidate_spectra = np.zeros((batch_size, dim))
    qvalues = np.zeros(batch_size)
    theoretical_spectra = []
    total_theo_pep = 0

    for spect_cnt, spectrum_id in enumerate(batch_idx):
        spectrum = dbs.spectrum_collection[spectrum_id]
        num_theo_pep = spectrum.end_pept - spectrum.start_pept
        if num_theo_pep == 0 or (cand_from_search_qval > -1 and spectrum.qvalue >= cand_from_search_qval):
            theoretical_spectra.append([])
            continue

        # Preprocess experimental spectrum
        dbs.discretize_spectrum(spectrum_id)
        dbs.normalize_regions(spectrum_id)

        # Prepare experimental spectrum
        if topN_exp > 0:
            dbs.normalize_regions(spectrum_id, N=topN_exp, initial=False)
        experimental_spectra[spect_cnt, :] = spectrum.spectrum_array

        # Use the best theoretical spectra from the previous search if its qvalue is better than the threshold            
        if spectrum.qvalue < cand_from_search_qval:
            peak_list = spectrum.peptide.unique_peaks
            candidate_spectra[spect_cnt, peak_list] = 1
            
        qvalues[spect_cnt] = spectrum.qvalue
        # Create theoretical spectra
        theo_pept_id_array = range(spectrum.start_pept, spectrum.end_pept)

        if num_theo_pep < min_candidates:
            start_id = spectrum.start_pept
            num_theo_pep = min_candidates
            end_id = start_id + min_candidates

            if end_id >= len(dbs.peptide_collection):
                end_id = len(dbs.peptide_collection)
                num_theo_pep = end_id - start_id   
            theo_pept_id_array = range(start_id, end_id)
                     
        theo_peaks = torch.zeros((num_theo_pep, dim), dtype=float_type, device=torch_device)
        for pept_cnt, peptide_id in enumerate(theo_pept_id_array):
            theo_peaks[pept_cnt, dbs.peptide_collection[peptide_id].unique_peaks] = dbs.max_intensity

        theoretical_spectra.append(theo_peaks)
        total_theo_pep += num_theo_pep

        # Delete array to free up space
        spectrum.spectrum_array = []

    if total_theo_pep == 0:
        return None, None, None, None
    return qvalues, experimental_spectra, candidate_spectra, theoretical_spectra
