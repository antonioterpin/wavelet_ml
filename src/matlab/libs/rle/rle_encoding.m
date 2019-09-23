function [rle_encoded_pixels_string, rle_encoded_pixels] = rle_encoding(pixels, dim)
% RLE_ENCODING Run RLE encoding algorithm on vectorized pixels map.
%   [rle_encoded_pixels_string, rle_encoded_pixels] = RLE_ENCODING(map) Run
%   RLE encoding algorithm on vectorized pixels map.
%
%   _ = RLE_ENCODING(pixels,dim) Build pixels map from pixels list and run
%   RLE encoding algorithm on vectorized map.
%
%   See also RLE_DECODING.

    assert(nargin <= 2, "Wrong number of arguments, check help.");

    A = [];
    if nargin == 2
        % for easy of use
        pixels = flip(pixels,2);
        % take pixels and encode in a binary matrix
        A = zeros(dim(1), dim(2));
        A((pixels(:,2) - 1) * dim(1) + pixels(:,1)) = 1;
    else
        A = pixels; % consider pixels as binary map
    end
    
    % diff finds the transition 0->1 (1) and 1->0 (-1)
    % == 1 finds only the beginning of a sequence of ones
    % ~A(1) guarantees that if the first element is one then we have a 0->1
    % transition and a beginning of a sequence of ones. Otherwise a -1 and
    % no sequence.
    sequences_beginning = double(diff([~A(1);A(:)]) == 1);
    
    % cumsum(sequences_beginning).*A(:) results in the block of ones
    % enumerated as 111...1, 222...2, ...
    % +1 is required from accumarray, so the block of ones are enumerated
    % as 222...2,333...3,..., while 0s are enumerated as 111...1
    % Because A(:) is binary, v(2:end) contains the length of the
    % sequences.
    v = accumarray(cumsum(sequences_beginning).*A(:)+1,A(:));
    rle_encoded_pixels = [find(sequences_beginning == 1)'; v(2:end)']; % [beginning; length]
    rle_encoded_pixels = rle_encoded_pixels(:); % vectorization
    rle_encoded_pixels_string = sprintf("%s%d",sprintf("%d ",rle_encoded_pixels(1:end-1)),rle_encoded_pixels(end));

end