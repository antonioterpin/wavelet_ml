function score = loss_function(encoded_proposed_pixels, encoded_correct_pixels, domain_size)
% LOSS_FUNCTION object detection considered metric.
%
%   score = LOSS_FUNCTION(proposed_pixels, correct_pixels)
%   Let X be the proposed_pixels set and Y be the correct_pixels set. Then:
%                   
%   score = 2 * |intersect(X, Y)| / (|X| + |Y|)

    X = rle_decoding(encoded_proposed_pixels, domain_size);
    Y = rle_decoding(encoded_correct_pixels, domain_size);
    
    score = 2 * size(intersect(X,Y,'rows'),1) / (size(X,1) + size(Y,1));

end