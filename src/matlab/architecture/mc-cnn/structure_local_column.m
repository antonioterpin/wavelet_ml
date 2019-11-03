function layers = structure_local_column()
%STRUCTURE_LOCAL_COLUMN Local column layers
%
%   layers = structure_local_column()
%
%   See also STRUCTURE_SHAPE_COLUMN, STRUCTURE_GLOBAL_COLUMN
    
    layers = [
    imageInputLayer([256 1600 1],"Name","imageinput")
    
    convolution2dLayer([3 3],4,"Name","shuffle","DilationFactor",[400 400],"Padding",[672 672 0 0])
    
    convolution2dLayer([3 3],8,"Name","conv1","Padding","same")
    maxPooling2dLayer([4 4],"Name","mp1","Padding","same","Stride",[4 4])
    
    convolution2dLayer([3 3],16,"Name","conv2","Padding","same")
    maxPooling2dLayer([4 4],"Name","mp2","Padding","same","Stride",[4 4])
    
    convolution2dLayer([3 3],32,"Name","conv3","Padding","same")
    maxPooling2dLayer([2 2],"Name","mp3","Padding","same","Stride",[2 2])
    
    convolution2dLayer([3 3],64,"Name","conv4","Padding","same")
    maxPooling2dLayer([2 2],"Name","mp4","Padding","same","Stride",[2 2])
    
    convolution2dLayer([3 3],128,"Name","conv5","Padding","same")
    maxPooling2dLayer([2 2],"Name","mp5","Padding","same","Stride",[2 2])
    
    fullyConnectedLayer(16,"Name","fc1")
    fullyConnectedLayer(16,"Name","fc2")
    fullyConnectedLayer(4,"Name","fc3")
    
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
end

