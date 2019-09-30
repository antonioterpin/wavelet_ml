function [layers] = structure_global_column(conv_filter_1_size, number_of_hidden_units)
%STRUCTURE_GLOBAL_COLUMN Returns the structure of the shape column
%   [layers] = structure_global_column() Returns the layers of the local
%   column of the mc-cnn
%
%   See also STRUCTURE_SHAPE_COLUMN, STRUCTURE_LOCAL_COLUMN
    
    global image_size number_defect_classes;
    
    if nargin < 2
        number_of_hidden_units = (number_defect_classes + 1) * 2;
    end
    if nargin < 1
        conv_filter_1_size = [image_size(1) floor(image_size(2)/3)];
    end

    layers = [
        imageInputLayer([image_size(1) image_size(2) 1]) % Shape feature is of the same size of raw images

        convolution2dLayer(conv_filter_1_size(1),conv_filter_1_size(2),'Padding',1) % TODO justify, 
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)
        flattenLayer % Put all in the same line
        
        fullyConnectedLayer(number_of_hidden_units)

        fullyConnectedLayer(number_defect_classes + 1) % Probability for no defect or one of the defect classes
        softmaxLayer % local column outputs probability for each class
        classificationLayer % cross entropy loss for multi-class classification with mutex classes
    ];
end

