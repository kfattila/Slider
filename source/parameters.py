import torch
# Parameters 
dbsearch = {
    'highres' : {'bin_width':0.1, 'bin_offset':0.0},
    'lowres' : {'bin_width':1.0005079, 'bin_offset':0.4},
    'max_peak' : 2000,
    'remove_precursor_peak' : True,
    'remove_precursor_tolerance' : 1.5,
    'max_theo_pept_peak_charge' : 2,
    'min_pept_len' : 7,
    'decoy_format' : 0, #0 for reverse, 1 for shuffle
    'max_intensity' : 1.0, 
}

types = {
    'float_type': torch.float32,
    'dtype': torch.FloatTensor, # use torch.cuda.FloatTensor in case GPU is available and torch.FloatTensor otherwise
    # 'torch_device': torch.device("cpu") # BoltzMatch training on CPU 
    'torch_device': torch.device("cuda:0") # BoltzMatch training on GPU 
}

training = {
    'window_width' : 10, #[5,10,20,50,200]
    'kernel_num' : 20, #[20,40,80,200], #40
    'epochs' :  20, 
    'batch_size':  16, #[16, 32, 64, 256], #32
    'learning_rate' : 0.005, #ups 0.001
    'target_from_theo_pept' : 0.005,
    'topN': 5000,
    # 'open_window_search' : False,
    'print_info' : True,
    # 'aux_peak_type' : True,
    'clip_value': 1,
    'layer_num': 2, #[2,3,5,10,20] #2
    'cand_from_search_qval' : 0.005, 
    'topN_exp' : 0,
    'print_info': True,
    'printing_tick': 1 # print learning update after this many epochs
}

evaluation = {
    'mixing_ratio' : [0.5, 0.7, 0.8, 0.9],
    'peaks_only' : [True,]
}

spectrum = {
    'humvar' : {
        'ms_data_file': '/home/data/mass_spec_data/Linfeng_012511_HapMap39_3.mgf',
        'fasta_file': '/home/data/Fasta/ipi.HUMAN.v3.87.fasta',
        'max_mods' : 1, #2
        'missed_cleavages' : 1, #1
        'enzyme':'trypsin',
        'tolarence_type' : "PPM",
        'tolarence_window' : 20,
        'static_mods': {'C+57.02146', 'Nt+229.16293'},
        'modifications' : {'[15.9949]':['M'],'[229.16293]':['K']},
        # 'static_mods': {'C+57.02146'},
        # 'modifications' : {'[15.9949]':['M'],'[229.16293]':['K'],'[229.16293]-':True},
        'pos_weight' : 20,
        'ylim_min' : 1000,
        'ylim_max' : 3250,
    },
   
    'ups1' : {
        'ms_data_file' : './data/UPS1.recalre.mgf',
        'fasta_file' : './data/ups1.fasta',
        'tolarence_type' : "PPM",
        'tolarence_window' : 100,
        'max_mods' : 1,
        'enzyme':'trypsin',
        'missed_cleavages' : 1,
        'static_mods': {'C+57.02146'},
        'modifications' : {'[15.9949]':['M']},
        'ylim_min' : 200,
        'ylim_max' : 800,
        'pos_weight' : 100,
    },
    
   'malaria' : {
        'ms_data_file' : '/home/data/mass_spec_data/v07548_UofF_malaria_TMT_10.mgf',
        'fasta_file' : '/home/data/Fasta/plasmo_Pfalciparum3D7_NCBI_new.fasta',
        'max_mods' : 1,
        'tolarence_type' : "PPM",
        'tolarence_window' : 30,
        'missed_cleavages' : 1,
        'enzyme':'lysc',
        'static_mods': {'C+57.02146', 'K+229.16293', 'Nt+229.16293'},
        'modifications' : {'[15.9949]':['M'],'[79.9663]':['STY']},
        'pos_weight' : 20,
    },

    'iprg' : {
        'ms_data_file' : '/home/data/mass_spec_data/iPRG2012_full_estimated_z.mgf',
        'fasta_file' : '/home/data/Fasta/ABRF_iPRG_2012_target.fasta',
        'tolarence_window' : 10,
        'tolarence_type' : "PPM",
        'max_mods' : 1,
        'missed_cleavages' : 1,
        'enzyme':'trypsin',
        'static_mods': {'C+57.02146'},
        'modifications' : {'[15.9949]':['M'],'[79.9663]':['STY']},
        'pos_weight' : 20,
    },
    'HeLa' : {
        'ms_data_file': '/hdd/data/HeLa/20150410_QE3_UPLC9_DBJ_SA_46fractions_Rep1_1.mgf',
        'fasta_file': '/home/data/Fasta/uniprot-proteome_UP000005640.fasta',  #use protein reverse for decoy generation.
        'max_mods' : 0,
        'missed_cleavages' : 2,
        'enzyme':'trypsin/p',   #Use trypsin without proline suppression.
        'tolarence_type' : "PPM",
        'tolarence_window' : 50,
        'static_mods': {'C+57.02146'},
        'modifications' : {},
        'pos_weight' : 20,
        'ylim_min' : 0000,
        'ylim_max' : 4000,
    },
    'Chopin' : {
        # 'ms_data_file': '/hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybrid.mgf',
        'ms_data_file': '/hdd/data/Chopin/FL0026_RFI_261114_Deep_High_Trypsin_F13F28_hybridFT_HCD_[Node_10].mgf',
        'fasta_file': '/home/data/Fasta/uniprot-proteome_UP000005640.fasta',  #use protein reverse for decoy generation.
        'max_mods' : 0,
        'missed_cleavages' : 2,
        'enzyme':'trypsin/p',   #Use trypsin without proline suppression.
        'tolarence_type' : "PPM",
        'tolarence_window' : 20,
        'static_mods': {'C+57.02146'},
        'modifications' : {},
        'pos_weight' : 20,
        'ylim_min' : 0000,
        'ylim_max' : 4000,
    },    
    }

def params_to_string(params):
    string = ''
    for key in params.keys():
        string += '-{}-{}'.format(key, params[key])
    return string[0:100]

def string_to_params(string):
    model_tokens = string.split('-')
    DATASET = model_tokens[0]
    RES = model_tokens[1]
    model_name = model_tokens[2]
    
    for i,token in enumerate(model_tokens):
        if token in training.keys():
            try:
                training[token] = int(model_tokens[i+1])
            except ValueError:
                training[token] = float(model_tokens[i+1])
    return (DATASET, RES, model_name)    



