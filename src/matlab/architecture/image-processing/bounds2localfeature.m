function [shape_feature,local_feature] = bounds2localfeature(encoded_shape_feature,bounding_box,image)
%ALPHA_SHAPE Given the region bounds returns both shape and local
%features.
%   [shape_feature,local_feature] = bounds2localfeature(bounds,image_size)
% See also SEGMENTATE_IMAGE, ALPHA_SHAPE
    shape_feature = zeros(size(image)); local_feature = zeros(size(image)); % black image
    [~,decoded_displaced_shape_feature] = rle_decoding(encoded_shape_feature,size(image));
    % center bounds
    % unwrap bounding box
    minX = bounding_box(1,1); minY = bounding_box(1,2);
    maxX = bounding_box(2,1); maxY = bounding_box(2,2);
    displacement_vector = floor([size(image,2) size(image,1)] / 2)...
        - floor(([maxX - minX maxY - minY]) / 2);
    shape_feature(displacement_vector(2):displacement_vector(2) + maxY - minY,...
        displacement_vector(1):displacement_vector(1) + maxX - minX) = ...
        decoded_displaced_shape_feature(minY:maxY,minX:maxX);
    local_feature(displacement_vector(2):displacement_vector(2) + maxY - minY,...
        displacement_vector(1):displacement_vector(1) + maxX - minX) = ...
        image(minY:maxY,minX:maxX);
end

