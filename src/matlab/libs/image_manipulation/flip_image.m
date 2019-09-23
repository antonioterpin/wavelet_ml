function image_rows = flip_image(image_row, type)
% FLIP_IMAGE Flips image I horizontally, vertically and both.
%
% See also FLIP

    if nargin < 2
        type = "jpg";
    end

    globals();
    global compressed_images column_image_id; % images
    global number_defect_classes column_encoded_pixels; % defects details
    
    % calculate relative path
    image_id = image_row{1,column_image_id}{1};
    image_filename = strcat(compressed_images, image_id);
    image = imread(image_filename);
    
    % image details
    im_height = size(image, 1);
    im_width = size(image, 2);
    
    % output filenames
    h_image_filename = insertBefore(image_id, sprintf("%s%s", ".", type), "_h");
    v_image_filename = insertBefore(image_id, sprintf("%s%s", ".", type), "_v");
    hv_image_filename = insertBefore(image_id, sprintf("%s%s", ".", type), "_hv");
    
    % save images
    imwrite(flip(image), strcat(compressed_images, h_image_filename));
    imwrite(flip(image, 2), strcat(compressed_images, v_image_filename));
    imwrite(flip(flip(image, 2)), strcat(compressed_images, hv_image_filename));
    
    % row data
    h_flip_row = image_row; h_flip_row{1, column_image_id}{1} = h_image_filename;
    v_flip_row = image_row; v_flip_row{1, column_image_id}{1} = v_image_filename;
    hv_flip_row = image_row; hv_flip_row{1, column_image_id}{1} = hv_image_filename;
    
    for i = 1 : number_defect_classes
        % decode rle
        pixels = rle_decoding(image_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1}, im_width, im_height);
        if size(pixels,1) > 0
            % horizontal flip
            h_pixels = pixels;
            h_pixels(:,2) = (im_height + 1) - h_pixels(:,2);
            h_flip_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1} = rle_encoding(h_pixels, im_width, im_height);

            % vertical flip
            v_pixels = pixels;
            v_pixels(:,1) = (im_width + 1) - v_pixels(:,1);
            v_flip_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1} = rle_encoding(v_pixels, im_width, im_height);

            % both 
            hv_flip_row{1,sprintf("%s%d", column_encoded_pixels, i)}{1} = rle_encoding([v_pixels(:,1) h_pixels(:,2)], im_width, im_height);
        end
    end
    
    image_rows = [h_flip_row; v_flip_row; hv_flip_row];

end