function highlighted_image = highlight_defects(image_row, use_buffered_image)
% HIGHLIGHT_DEFECTS Highlight defective region borders in image.
%
%   highlighted_image = highlight_defects(image_row) Paints over the image
%   specified in the column_image_id column of image_row the borders of the
%   areas described in column_encoded_pixels columns.
%   
%   highlighted_image = highlight_defects(_, use_buffered_image)
%   use_buffered_image determines whether the routine should look for
%   previously saved image (default option, use_buffered_image = true) or
%   it should produce a brand new output image unconditionally.
%
% See also ALPHA_SHAPE, INSERTMARKER

    if nargin < 2
        use_buffered_image = true;
    end
    
    globals();
    
    global compressed_images defects_highlighted; % images paths
    global number_defect_classes column_encoded_pixels column_image_id; % dataset details
    global defects_colors; % highlight colors
    
    % calculate relative path
    image_id = image_row{1,column_image_id}{1};
    image_filename = strcat(compressed_images, image_id);
    output_image_filename = strcat(defects_highlighted, image_id);
    
    % buffer check
    if isfile(output_image_filename) && use_buffered_image
        % Image already processed.
        highlighted_image = imread(output_image_filename);
    else
         % load original image
         highlighted_image = imread(image_filename);
         
         % highlight defects
         for i = 1 : number_defect_classes
             rle_encoded_pixels = image_row{1, sprintf("%s%d", column_encoded_pixels, i)}{1};
             if strcmp(rle_encoded_pixels, "") == 0
                 % image has this kind of defect
                 pixels = rle_decoding(rle_encoded_pixels, size(highlighted_image));
                 shp = alphaShape(pixels(:,1),pixels(:,2));
                 [~, bounds] = boundaryFacets(shp);
                 highlighted_image = insertMarker(highlighted_image, bounds, "color", {defects_colors(i)});
             end
         end
         
         % buffer
         imwrite(highlighted_image, output_image_filename);
    end

end