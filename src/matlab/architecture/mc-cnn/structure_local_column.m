function layers = structure_local_column()
%STRUCTURE_LOCAL_COLUMN Local column layers
%
%   layers = structure_local_column()
%
%   See also STRUCTURE_SHAPE_COLUMN, STRUCTURE_GLOBAL_COLUMN
    
    layers = [
    imageInputLayer([256 1600 1],"Name","imageinput")
    
    convolution2dLayer([11 1],2,"Name","conv_1")
    convolution2dLayer([1 11],2,"Name","conv_2")
    batchNormalizationLayer
    leakyReluLayer(0.01,"Name","leakyrelu_1")
    maxPooling2dLayer([3 3],"Name","maxpool_1","Padding","same","Stride",[2 2])
    
    convolution2dLayer([7 1],2,"Name","conv_5")
    convolution2dLayer([1 7],2,"Name","conv_6")
    batchNormalizationLayer
    leakyReluLayer(0.01,"Name","leakyrelu_3")
    maxPooling2dLayer([3 3],"Name","maxpool_3","Padding","same","Stride",[2 2])
    
    convolution2dLayer([5 1],2,"Name","conv_3")
    convolution2dLayer([1 5],2,"Name","conv_4")
    batchNormalizationLayer
    leakyReluLayer(0.01,"Name","leakyrelu_2")
    maxPooling2dLayer([3 3],"Name","maxpool_2","Padding","same","Stride",[2 2])
    
    convolution2dLayer([3 1],3,"Name","conv_7")
    convolution2dLayer([1 3],3,"Name","conv_8")
    batchNormalizationLayer
    leakyReluLayer(0.01,"Name","leakyrelu_4")
    maxPooling2dLayer([3 3],"Name","maxpool_4","Padding","same","Stride",[2 2])
    
    convolution2dLayer([3 1],3,"Name","conv_9")
    convolution2dLayer([1 3],3,"Name","conv_10")
    batchNormalizationLayer
    leakyReluLayer(0.01,"Name","leakyrelu_5")
    maxPooling2dLayer([3 3],"Name","maxpool_5","Padding","same","Stride",[2 2])
    
    convolution2dLayer([1 1],3,"Name","conv_11")
    convolution2dLayer([1 3],3,"Name","conv_12")
    batchNormalizationLayer
    leakyReluLayer(0.01,"Name","leakyrelu_6")
    maxPooling2dLayer([3 3],"Name","maxpool_6","Padding","same","Stride",[2 2])
    
    fullyConnectedLayer(7,"Name","fc_1")
    fullyConnectedLayer(4,"Name","fc_2")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
end

