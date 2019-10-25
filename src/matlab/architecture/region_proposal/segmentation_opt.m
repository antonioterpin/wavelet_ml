
% parameters
class = 3;
batch_size = 10;

% hyperparameters to optimize
hyst_tl = optimizableVariable('hyst_tl',[0 60],'Type','integer');
hyst_th = optimizableVariable('hyst_th',[60 255],'Type','integer');
alpha = optimizableVariable('alpha',[5 20],'Type','integer');
hole_th = optimizableVariable('hole_th',[500 5000],'Type','integer');
region_th = optimizableVariable('region_th',[500 5000],'Type','integer');

hyp_segmentation = [hyst_tl, hyst_th, alpha, hole_th, region_th];

% dataset images
global global_feature_images
images = imageDatastore(convertStringsToChars(global_feature_images),...
          'IncludeSubfolders', true, 'LabelSource', 'foldernames'); % use foldernames as labels

% dataset csv
global augmented_dataset_path
dataset = readtable(augmented_dataset_path, 'Delimiter', ',');

% bayesian optimization
segmentation_opt_results = bayesopt(@(params)err_segmentation(params, images, dataset, class, batch_size),...
                                    hyp_segmentation,...
                                    'AcquisitionFunctionName','expected-improvement-plus',...
                                    'Verbose',1);
                            
hyp_segmentation_opt = segmentation_opt_results.XAtMinObjective;     
loss_segmentation_opt = segmentation_opt_results.MinObjective;     

% objective function evaluation
function err = err_segmentation(params, images, dataset, class, batch_size)
    
    if class == 1
        class_str = '1000';
    elseif class == 2
        class_str = '0100';
    elseif class == 3
        class_str = '0010';
    elseif class == 4
        class_str = '0001';
    end
    
    idx = find(images.Labels == class_str);
    s = RandStream('mlfg6331_64','Seed',10); 
    idx = sort(randsample(s,idx,batch_size,false));
    % images_class = subset(images,idx);

    err = 0;
   
    for n = 1:length(idx)
        
        i = idx(n);
        im = readimage(images,i);
        im_size = size(im);
        
        [filepath,name,ext] = fileparts(cell2mat(images.Files(i)));
        filename = strcat(name,ext);
        
        encoded_correct_pixels = cell2mat(dataset{find(strcmp(filename,dataset{:,1})),class+1});
        
        % bounding box correct pixels
        [~, map] = rle_decoding(encoded_correct_pixels, im_size);
        [number_of_regions, ~, bounding_boxes] = segmentate_image(map);
        correct_pixels = zeros(im_size);                                                                 
        for region_id = 1:number_of_regions
            correct_pixels(bounding_boxes(1,2,region_id):bounding_boxes(2,2,region_id), ...
                         bounding_boxes(1,1,region_id):bounding_boxes(2,1,region_id)) = 1;
        end                      
        encoded_correct_pixels = rle_encoding(correct_pixels);
        
        %imshow(correct_pixels);
    
        % region proposal
        map = defect_edge_detection(im, params.hyst_tl, params.hyst_th);
        [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map,...
                                                                                        params.alpha,...
                                                                                        params.hole_th,...
                                                                                        params.region_th);
        
        im_segmented = zeros(im_size);                                      
        for region_id = 1:number_of_regions
            im_segmented(bounding_boxes(1,2,region_id):bounding_boxes(2,2,region_id), ...
                         bounding_boxes(1,1,region_id):bounding_boxes(2,1,region_id)) = 1;
        end
                                           
        encoded_proposed_pixels = rle_encoding(im_segmented);
        
        err = err + 1 - loss_function(encoded_proposed_pixels, encoded_correct_pixels, im_size);
        
    end
    
    err = err ./ batch_size;
    
end