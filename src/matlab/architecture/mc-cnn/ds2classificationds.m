% @DEPRECATED

function classificationds = ds2classificationds(dataset)
%DS2CLASSIFICATIONDS Given a dataset creates its labels only for
%classification
%   Detailed explanation goes here
%   classificationds = ds2classificationds(dataset)

    type = "jpg";
    global number_defect_classes; % data
    global column_image_id column_encoded_pixels column_defect_class; % columns
    global compressed_images shape_feature_images local_feature_images; % images folders
    
    number_of_images = size(dataset,1);
    classificationds = cell2table(cell(0,2)); % create empty table
    
    classification_dataset_waitbar = waitbar(0,"Segmenting images...");
    for image_index = 1 : number_of_images
        waitbar(image_index / number_of_images,classification_dataset_waitbar,...
            sprintf("Segmenting images...\nImage %d of %d",image_index,number_of_images));
        image_row = dataset(image_index,:);
        image_id = image_row{1,column_image_id}{1};
        image = imread(sprintf("%s%s",compressed_images,image_id));
        for class_id = 1 : number_defect_classes
            encoded_pixels = image_row{1,sprintf("%s%d",column_encoded_pixels,class_id)}{1};
            [~,map] = rle_decoding(encoded_pixels,size(image));
            % TODO REMARK NO NEGATIVE EXAMPLES!!!!!!!!!
            if find(map ~= 0)
                [number_of_regions,encoded_shape_features,bounding_boxes] = segmentate_image(map);
                % Iterate over regions
                for region_id = 1 : number_of_regions
                    [shape_feature, local_feature] = bounds2localfeature(...
                        encoded_shape_features(region_id), ...
                        bounding_boxes(:,:,region_id), image);
                    % save shape_feature & local_feature
                    new_image_id = insertBefore(image_id, sprintf("%s%s", ".", type), sprintf("%d%d",class_id,region_id));
                    imwrite(shape_feature,sprintf("%s%s",shape_feature_images,new_image_id));
                    imwrite(uint8(local_feature),sprintf("%s%s",local_feature_images,new_image_id));
                    classificationds = [classificationds; {new_image_id,class_id}];
                end
            end
        end
    end
    close(classification_dataset_waitbar);
    
    % Rename columns
    classificationds.Properties.VariableNames = {sprintf('%s',column_image_id), sprintf('%s',column_defect_class)};
    
end

