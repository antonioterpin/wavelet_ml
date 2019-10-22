function image_rows = flip_image(image_row, type)
% FLIP_IMAGE Flips image horizontally, vertically and both.
%
%   image_rows = flip_image(image_row) Given the image_row returns an array
%   of three image rows (image_rows) containing the transformed images
%   filenames and their relative encoded pixels, which are linearly
%   transformed.
%   image_row is composed by column_image_id with the image filename, and
%   #number_defect_classes columns of column_encoded_pixels.
%
%   image_rows = flip_image(_, type) To specify image type. Default
%   is "jpg".
%
%   Example:
%
%       Original               Flipped         Flipped        Flipped
%                             Vertical       Horizontally       Both
%     _         _            _         _     _         _     _         _
%    | 0 1 0 1 1 |          | 1 1 0 1 0 |   | 0 0 1 0 0 |   | 0 0 1 0 0 |   
%    | 0 1 1 1 0 |  ===>    | 0 1 1 1 0 |   | 0 0 1 1 0 |   | 0 1 1 0 0 |
%    | 0 0 1 1 0 |          | 0 1 1 0 0 |   | 0 1 1 1 0 |   | 0 1 1 1 0 |
%    | 0 0 1 0 0 |          | 0 0 1 0 0 |   | 0 1 1 1 1 |   | 1 1 1 1 0 |
%     -         -            -         -     -         -     -         -
%   Relative encoded pixels are encoded properly.   
%
% See also FLIP, RLE_DECODING, RLE_ENCODING

    if nargin < 2
        type = "jpg";
    end

    globals();
    global compressed_images preprocessed_images augmentated_images augmentated_preprocessed_images column_image_id; % images
    global number_defect_classes column_encoded_pixels; % defects details
    
    % calculate relative path
    image_id = image_row{1,column_image_id}{1};
    image_filename = strcat(compressed_images, image_id);
    image_preprocessed_filename = strcat(preprocessed_images, image_id);
    
    image = imread(image_filename);
    image_preprocessed = imread(image_preprocessed_filename);
    
    % image details
    image_size = size(image);
    im_height = size(image, 1);
    im_width = size(image, 2);
    
    % output filenames
    h_image_filename = insertBefore(image_id, sprintf("%s%s", ".", type), "_h");
    v_image_filename = insertBefore(image_id, sprintf("%s%s", ".", type), "_v");
    hv_image_filename = insertBefore(image_id, sprintf("%s%s", ".", type), "_hv");
    
    % save images
    imwrite(flip(image), strcat(augmentated_images, h_image_filename));
    imwrite(flip(image, 2), strcat(augmentated_images, v_image_filename));
    imwrite(flip(flip(image, 2)), strcat(augmentated_images, hv_image_filename));
    
    imwrite(flip(image_preprocessed), strcat(augmentated_preprocessed_images, h_image_filename));
    imwrite(flip(image_preprocessed, 2), strcat(augmentated_preprocessed_images, v_image_filename));
    imwrite(flip(flip(image_preprocessed, 2)), strcat(augmentated_preprocessed_images, hv_image_filename));
    
    % row data
    h_flip_row = image_row; h_flip_row{1, column_image_id}{1} = h_image_filename;
    v_flip_row = image_row; v_flip_row{1, column_image_id}{1} = v_image_filename;
    hv_flip_row = image_row; hv_flip_row{1, column_image_id}{1} = hv_image_filename;
    
    for i = 1 : number_defect_classes
        % decode rle
        pixels = rle_decoding(image_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1}, image_size);
        if size(pixels,1) > 0
            % horizontal flip
            h_pixels = pixels;
            h_pixels(:,2) = (im_height + 1) - h_pixels(:,2);
            h_flip_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1} = rle_encoding(h_pixels, image_size);

            % vertical flip
            v_pixels = pixels;
            v_pixels(:,1) = (im_width + 1) - v_pixels(:,1);
            v_flip_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1} = rle_encoding(v_pixels, image_size);

            % both 
            hv_flip_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1} = rle_encoding([v_pixels(:,1) h_pixels(:,2)], image_size);
        end
    end
    
    image_rows = [h_flip_row; v_flip_row; hv_flip_row];

end