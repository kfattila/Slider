
import numpy as np
import seaborn as sns
import pandas as pd
import matplotlib.pyplot as plt      
import torch

def plot_masses(ax, masses, annotate=True):
    prev_m = -10
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

def plot_weights(model, spy, filename_stem):

    fig=plt.figure(figsize=(20,30))

    # Get amino acid masses
    masses = pd.read_csv("masses.txt",sep="\t")["mono mass"]
    discretized_masses = spy.mass2bin_vec(masses)
    
    # Get model weights
    if len(model.filter_pre.size()) > 1:
        weights1 = np.flip(torch.mean(model.filter_pre, dim=0).data.cpu().numpy(),0)
        weights2 = torch.mean(model.filter_post, dim=0).data.cpu().numpy()
    else:
        weights1 = np.flip(model.filter_pre.data.cpu().numpy(),0)
        weights2 = model.filter_post.data.cpu().numpy()


    # pre_weights
    # print(len(model.filter_pre.size()))
    # exit()
    ax1 = plt.subplot(311)
    ax1.bar(np.arange(len(weights1)),weights1 ) 
    ax1.set_title('Right side weights',fontdict={'fontsize':16},loc='left')
    plot_masses(ax1,discretized_masses,False)

    # post_weights
    ax2 = plt.subplot(312)
    ax2.bar(np.arange(len(weights2)),weights2)
    ax2.set_title('Left side weights',fontdict={'fontsize':16},loc='left')
    plot_masses(ax2,discretized_masses,False)

    #
    weights3 = weights1 + weights2
    ax3 = plt.subplot(313)
    ax3.bar(np.arange(len(weights3)),weights3 ) 
    ax3.set_title('Sum of weights',fontdict={'fontsize':16},loc='left')
    plot_masses(ax3,discretized_masses)
    fig.savefig(filename_stem+'.weight.png')
    plt.clf()  
    plt.close()

def plot_learning_curve(learning_curve, filename_stem):
    data = pd.DataFrame(learning_curve, columns=["Learning Curve"])
    data.to_csv(path_or_buf=filename_stem+".learning_curve")
    sns_plot = sns.lineplot(data=data, linewidth=2.5)
    sns_plot.figure.savefig(filename_stem+'.lc.png')
