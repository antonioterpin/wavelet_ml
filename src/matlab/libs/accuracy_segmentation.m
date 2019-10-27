function score = accuracy_segmentation(encoded_proposed_pixels, encoded_correct_pixels, domain_size)
% ACCURACY_SEGMENTATION accuracy of the region proposal architecture
%
%   score = ACCURACY_SEGMENTATION(proposed_pixels, correct_pixels) given the 
%   proposed_pixels (X) and the correct_pixels (Y), gives the score: 
%   score = |X ? Y| / |Y|

    proposed_pixels = rle_decoding(encoded_proposed_pixels, domain_size);
    correct_pixels = rle_decoding(encoded_correct_pixels, domain_size);
    
%     X = cellstr(num2str(proposed_pixels));
    X = proposed_pixels;
%     Y = cellstr(num2str(correct_pixels));
    Y = correct_pixels;
    
%     score = size(intersect(X,Y),1) / size(Y,1);
    score = size(intersect(X,Y,'rows'),1) / size(Y,1);
end