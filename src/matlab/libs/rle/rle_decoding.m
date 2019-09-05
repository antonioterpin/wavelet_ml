function [pixels, pixels_binary] = rle_decoding(rle_encoded_pixels, im_width, im_height)
% RLE_DECODING Given rle_encoded_pixels string, im_height (image height) 
%   and im_width (image width) returns the pixels decoded as [X Y] coordinates

    % conversion from string to array of int
    rle_encoded_pixels_array = str2num(rle_encoded_pixels);
    [X, Y] = meshgrid(1:im_width, 1:im_height);
    rle_encoded_pixels_resolution_matrix = [X(:) Y(:)];
    
    pixels = zeros(sum(rle_encoded_pixels_array(2:2:end)), 2);
    last = 1;
    for i = 1:2:size(rle_encoded_pixels_array,2)
        from = rle_encoded_pixels_array(i); length = rle_encoded_pixels_array(i+1) - 1;
        pixels(last:last + length, :) = rle_encoded_pixels_resolution_matrix(from:from + length, :);
        last = last + length + 1;
    end
    
    pixels_binary = zeros(im_height, im_width);
    pixels_binary((pixels(:,2) - 1) * im_height + pixels(:,1)) = 1;
end