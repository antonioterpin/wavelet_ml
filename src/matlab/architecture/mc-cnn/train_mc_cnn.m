function net = train_mc_cnn(X,Y,layers)
%TRAIN_MC_CNN Train merged mc-cnn.
%   
%   TODO
%
%   See also TODO

    options = trainingOptions('sgdm', ...
    'InitialLearnRate',0.01, ...
    'MaxEpochs',10, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');
    
    net = trainNetwork(X, Y, layers, options);
end

