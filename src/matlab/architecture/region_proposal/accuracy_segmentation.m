function score = accuracy_segmentation(encoded_proposed_pixels, encoded_correct_pixels, domain_size)
% ACCURACY_SEGMENTATION accuracy of the region proposal architecture
%
%   score = ACCURACY_SEGMENTATION(proposed_pixels, correct_pixels)
%   Let X be the proposed_pixels set and Y be the correct_pixels set. Then:
%                   
%   score = |intersect(X, Y)| / |Y|

    proposed_pixels = rle_decoding(encoded_proposed_pixels, domain_size);
    correct_pixels = rle_decoding(encoded_correct_pixels, domain_size);
    
    X = proposed_pixels;
    Y = correct_pixels;
    score = size(intersect(X,Y,'rows'),1) / size(Y,1);

end