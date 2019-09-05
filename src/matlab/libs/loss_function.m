function score = loss_function(proposed_pixels, correct_pixels)
    % LOSS_FUNCTION given the proposed_pixels (X) and the correct_pixels
    % (Y), gives the score: 2 * |X ? Y| / (|X| + |Y|)
    
    X = cellstr(num2str(proposed_pixels));
    Y = cellstr(num2str(correct_pixels));
    
    score = 2 * size(intersect(X,Y),1) / (size(X,1) + size(Y,1));
end