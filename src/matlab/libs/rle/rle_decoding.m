function [pixels, map] = rle_decoding(rle_encoded_pixels, dim)
% RLE_DECODING Decode rle_encoded_pixels and returns list of encoded pixels and a binary map.
%   [pixels, map] = RLE_DECODING(rle_encoded_pixels, dim)
%
%   See also RLE_ENCODING.

    im_width = dim(2); im_height = dim(1);

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
    
    map = zeros(im_height, im_width);
    map((pixels(:,1) - 1) * im_height + pixels(:,2)) = 1;
end