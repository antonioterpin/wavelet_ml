function [shape_feature,local_feature,displacement_vector] = bounds2localfeature(encoded_shape_feature,bounding_box,image)
%BOUNDS2LOCALFEATURE Calculates shape_feature and local_feature.
%   
%   [shape_feature,local_feature] = bounds2localfeature(encoded_shape_feature,bounding_box,image)
%   Given the encoded_shape_feature, i.e. the encoded border pixels, the
%   bounding_box, i.e. the top-left and bottom-right rectangular delimiters
%   of the region, and the original image, calculates the shape_feature and
%   the local_feature. The former is a binary matrix illustrating the
%   border centered in the image domain, whereas the latter is a gray scale
%   crop of the area in the original image bounded by the given bounding
%   box. Also this is centered in the image domain.
%
% See also SEGMENTATE_IMAGE, RLE_ENCODING, RLE_DECODING

    image_size = size(image);
    shape_feature = zeros(image_size); local_feature = zeros(image_size); % black image
    [~,decoded_displaced_shape_feature] = rle_decoding(encoded_shape_feature,image_size);
    % center bounds
    % unwrap bounding box
    minX = bounding_box(1,1); minY = bounding_box(1,2);
    maxX = bounding_box(2,1); maxY = bounding_box(2,2);
    displacement_vector = floor([image_size(2) image_size(1)] / 2)...
        - floor(([maxX - minX maxY - minY]) / 2);
    shape_feature(displacement_vector(2):displacement_vector(2) + maxY - minY,...
        displacement_vector(1):displacement_vector(1) + maxX - minX) = ...
        decoded_displaced_shape_feature(minY:maxY,minX:maxX);
    if image_size(1) >= maxY && image_size(2) >= maxX
        local_feature(displacement_vector(2):displacement_vector(2) + maxY - minY,...
            displacement_vector(1):displacement_vector(1) + maxX - minX) = ...
            image(minY:maxY,minX:maxX);
    end
end

