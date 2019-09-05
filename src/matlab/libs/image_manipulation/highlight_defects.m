function highlighted_image = highlight_defects(image_row)
% HIGHLIGHT_DEFECTS highlights the area in the image given in image_row
%   with the colors specified in the globals file.
    
    globals();
    
    global images_path defects_highlighted; % images paths
    global number_defect_classes column_encoded_pixels column_image_id; % dataset details
    global defects_colors; % highlight colors
    
    % calculate relative path
    image_id = image_row{1,column_image_id}{1};
    image_filename = strcat(images_path, image_id);
    output_image_filename = strcat(defects_highlighted, image_id);
    
    % buffer check
    if isfile(output_image_filename)
        % Image already processed.
        highlighted_image = imread(output_image_filename);
    else
         % load original image
         highlighted_image = imread(image_filename);
         
         % highlight defects
         for i = 1 : number_defect_classes
             rle_encoded_pixels = image_row{1, sprintf('%s%d', column_encoded_pixels, i)}{1};
             if strcmp(rle_encoded_pixels, '') == 0
                 % image has this kind of defect
                 pixels = rle_decoding(rle_encoded_pixels, size(highlighted_image, 2), size(highlighted_image, 1));
                 shp = alphaShape(pixels(:,1),pixels(:,2));
                 [~, bounds] = boundaryFacets(shp);
                 highlighted_image = insertMarker(highlighted_image, bounds, 'color', {defects_colors(i)});
             end
         end
         
         % buffer
         imwrite(highlighted_image, output_image_filename);
    end

end