function [layers] = structure_local_column()
%STRUCTURE_LOCAL_COLUMN Returns the structure of the shape column
%   [layers] = structure_local_column() Returns the layers of the local
%   column of the mc-cnn
%
%   See also STRUCTURE_SHAPE_COLUMN, STRUCTURE_GLOBAL_COLUMN
    
    layers = [
    imageInputLayer([256 1600 1])
    
    convolution2dLayer(7,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(5,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    fullyConnectedLayer(4)
    softmaxLayer
    classificationLayer];
end

