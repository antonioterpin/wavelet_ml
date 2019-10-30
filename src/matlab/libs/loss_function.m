function score = loss_function(encoded_proposed_pixels, encoded_correct_pixels, domain_size)
% LOSS_FUNCTION object detection considered metric.
%
%   score = LOSS_FUNCTION(proposed_pixels, correct_pixels) given the 
%   Let X be the proposed_pixels set and Y be the correct_pixels set. Then:
%                   
%   score = 2 * |intersect(X, Y)| / (|X| + |Y|)

    proposed_pixels = rle_decoding(encoded_proposed_pixels, domain_size);
    correct_pixels = rle_decoding(encoded_correct_pixels, domain_size);
    
    X = cellstr(num2str(proposed_pixels));
    Y = cellstr(num2str(correct_pixels));
    
    score = 2 * size(intersect(X,Y),1) / (size(X,1) + size(Y,1));
end