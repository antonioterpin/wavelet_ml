function [pixels, map] = rle_decoding(rle_encoded_pixels, dim)
% RLE_DECODING RLE decoding.
%
%   [pixels, map] = RLE_DECODING(rle_encoded_pixels, dim) Decode a string
%   of rle_encoded_pixels and returns list of encoded pixels and a binary map.
%   rle_encoded_pixels is a string representing an array of an even
%   number of integers. dim contains the size of the 2D matrix. Pixels
%   enumeration consider the vectorization (on columns) of the matrix.
%   Sequences of adjacents pixels are encoded by starting position (odd
%   position integer) and sequence length (even position integer).
%
%   Example:
%   rle_encoded_pixels = "5 2 10 6 17 1"; dim = [4 5];
%   These data represents the following map:
%           _         _
%          | 0 1 0 1 1 |
%    map = | 0 1 1 1 0 |  which contains the pixels ([x,y]):
%          | 0 0 1 1 0 |  pixels = [2 1; 2 2; 3 2; 3 3; 3 4; 4 1; 4 2; 4 3; 5 1]
%          | 0 0 1 0 0 |
%           -         -
%
%   See also RLE, RLE_ENCODING.

    im_height = dim(1); im_width = dim(2);

    % conversion from string to array of int
    rle_encoded_pixels_array = str2num(rle_encoded_pixels); % this is ok, we are not working on scalar values
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