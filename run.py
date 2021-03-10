import sys
import main_train_slider

dataset = sys.argv[1]
res = sys.argv[2]
gpu_id = sys.argv[3]
    
main_train_slider.DATASET = dataset
main_train_slider.RES = res
main_train_slider.GPU_ID = gpu_id


training = {
    'window_width' : 10, 
    'kernel_num' : 20, 
    'epochs' :  2, 
    'batch_size':  128, #[16, 32, 64, 256], #32
    'learning_rate' : 0.1, #ups 0.001
    'target_from_theo_pept' : 0.005,
    'topN': 5000,
    'clip_value': 1,
    'cand_from_search_qval' : 0.005, 
    'print_info': True,
    'printing_tick': 5 # print learning update after this many epochs
}

print(training)

filename_stem = main_train_slider.main(training)
