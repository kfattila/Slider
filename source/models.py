import torch
import numpy as np

        
class DeepConv(torch.nn.Module):
    """
    Make a convolution layer with untrainable center explicitly.
    """
    def __init__(self,window_width, kernel_num, activation_fnc=torch.nn.functional.relu, spectrum_size=None, torch_device=None, torch_type=None):
        super(DeepConv,self).__init__()
        self.__class__.__name__ += '_'+activation_fnc.__class__.__name__
        self.window_width = window_width
        self.kernel_num = kernel_num
        bias = True
        self.sigmoid = torch.nn.Sigmoid()
    
        in_channels = 1
        
        self.layer1 = torch.nn.Sequential(
            torch.nn.BatchNorm1d(num_features=1),
            torch.nn.Conv1d(in_channels, self.kernel_num, self.window_width*2+1, padding=self.window_width, bias=bias),
            torch.nn.BatchNorm1d(num_features=self.kernel_num),
            torch.nn.Sigmoid(),
            )
            
        self.layer2 = torch.nn.Sequential(
            torch.nn.Conv1d(self.kernel_num, 1, 1, padding=0, bias=bias),
            torch.nn.BatchNorm1d(num_features=1),
            )
        self.bias =  torch.nn.Parameter(torch.tensor(5.0, requires_grad=True))#   nn.Parameters(torch.zeros(1))
        self.offset = torch.tensor(0.0/self.kernel_num)

    def forward(self, x):
        out = self.layer1(x) - self.offset   # shape: [batch_size, channel, spectrum_bin]
        out = self.layer2(out) - self.offset - self.bias
        return self.sigmoid(out)
    
    def clip_grads(self, clip_value=0.0001):
        # for layer in self.layers:
        self.layer1[0].weight.grad.data.clamp_(min=-clip_value, max=clip_value)
        self.layer2[0].weight.grad.data.clamp_(min=-clip_value, max=clip_value)
    
       
            
class BCELossWeight(torch.nn.BCELoss):
    """
    Make a convolution layer with untrainable center explicitly.
    """
    def __init__(self,pos_weight):
        super(torch.nn.BCELoss,self).__init__()
        # self.__class__.__name__ += '_'+"_pos_weight"
        self.pos_weight = pos_weight
        self.tiny = 1e-20
      

    def forward(self, estimated, target):
        cost = self.pos_weight*target*torch.log(estimated + self.tiny) + (1-target)*torch.log(1-estimated + self.tiny)

        return -cost.mean()