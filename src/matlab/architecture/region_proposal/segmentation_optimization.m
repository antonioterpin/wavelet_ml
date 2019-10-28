function [results, params] = segmentation_optimization(images, dataset, class, batch_size, n_iter)
% SEGMENTATION_OPT Optimization of the region proposal architecture
%
%   [results, params] = segmentation_opt(images, dataset, class, batch_size, n_iter) launch the
%   bayesian optimization routine over kovesi-hysteretic edge detector and alpha shape pipeline.
%   TODO describe input/output.
%
%   See also SEGMENTATION_TEST SEGMENTATION_TEST_IM

    global results_segmentation_optimization_dir
    
    file_log = convertStringsToChars(strcat(results_segmentation_optimization_dir,"log_class",num2str(class),"_batch",num2str(batch_size),"_niter",num2str(n_iter),sprintf("_%f",now),".out"));
    file_data = convertStringsToChars(strcat(results_segmentation_optimization_dir,"data_class",num2str(class),"_batch",num2str(batch_size),"_niter",num2str(n_iter),sprintf("_%f",now),".mat"));
    file_params = convertStringsToChars(strcat(results_segmentation_optimization_dir,"params_class",num2str(class),"_batch",num2str(batch_size),"_niter",num2str(n_iter),sprintf("%f",now),".mat"));
    file_plot = convertStringsToChars(strcat(results_segmentation_optimization_dir,"plot_class",num2str(class),"_batch",num2str(batch_size),"_niter",num2str(n_iter),sprintf("%f",now),".png"));

    % hyperparameters to optimize
    kov_nscale = optimizableVariable('kov_nscale',[3 6],'Type','integer');
    kov_norient = optimizableVariable('kov_norient',[4 16],'Type','integer');
    kov_min_wl = optimizableVariable('kov_min_wl',[2 5],'Type','real');
    kov_mult = optimizableVariable('kov_mult',[1.1 3],'Type','real');
    hyst_tl = optimizableVariable('hyst_tl',[5 80],'Type','integer');
    % hyst_tl = optimizableVariable('hyst_tl',[0 0.6],'Type','real');
    hyst_th = optimizableVariable('hyst_th',[80 255],'Type','integer');
    % hyst_th = optimizableVariable('hyst_th',[0 0.6],'Type','real');
    alpha = optimizableVariable('alpha',[5 20],'Type','integer');
    hole_th = optimizableVariable('hole_th',[500 15000],'Type','integer');
    region_th = optimizableVariable('region_th',[500 15000],'Type','integer');

    hyp_segmentation = [kov_nscale, kov_norient, kov_min_wl, kov_mult, ...
                        hyst_tl, hyst_th, ...
                        alpha, hole_th, region_th];

    diary(file_log);
    
    fprintf("SEGMENTATION OPTIMIZATION STARTED\n");
    fprintf("class: %d\nbatch_size: %d\nn_iter: %d\n\n", class, batch_size, n_iter);
    
    % bayesian optimization
    results = bayesopt(@(params)err_segmentation(params, images, dataset, class, batch_size),...
                       hyp_segmentation,...
                       'AcquisitionFunctionName','expected-improvement-plus',...
                       'MaxObjectiveEvaluations',n_iter,...
                       'UseParallel',true,...
                       'Verbose',1,...
                       'OutputFcn',@saveToFile,...
                       'SaveFileName',file_data);
                                    
                       % 'XConstraintFcn',@hyst_constraint,...
    
    diary off;
  
    % loss = segmentation_opt_results.MinObjective;
    params = table2struct(results.XAtMinObjective);
    save(file_params,'params');
    
    saveas(gcf,file_plot)

end

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
        
        [~,name,ext] = fileparts(cell2mat(images.Files(i)));
        filename = strcat(name,ext);
        
        % ACTUAL REGIONS
        encoded_correct_pixels = cell2mat(dataset{strcmp(filename,dataset{:,1}),class+1});
        
        % bounding box correct pixels
        % [~, map] = rle_decoding(encoded_correct_pixels, im_size);
        % [number_of_regions, ~, bounding_boxes] = segmentate_image(map);
        % correct_pixels = zeros(im_size);                                                                 
        % for region_id = 1:number_of_regions
        %     correct_pixels(bounding_boxes(1,2,region_id):bounding_boxes(2,2,region_id), ...
        %                  bounding_boxes(1,1,region_id):bounding_boxes(2,1,region_id)) = 1;
        % end                      
        % encoded_correct_pixels = rle_encoding(correct_pixels);
        
        % imshow(correct_pixels);
    
        % REGION PROPOSAL
        
        % edge detection
        map = defect_edge_detection(im,...
                                    params.kov_nscale,...
                                    params.kov_norient,...
                                    params.kov_min_wl,...
                                    params.kov_mult,...
                                    params.hyst_tl,...
                                    params.hyst_th);
        
        map(1:end,1) = 1;
        map(1,1:end) = 1;
        map(end, 1:end) = 1;
        map(1:end, end) = 1;
        
        % segmentation
        [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map,...
                                                                                        params.alpha,...
                                                                                        params.hole_th,...
                                                                                        params.region_th);
        % bounding box
        im_segmented = zeros(im_size);                                      
        for region_id = 1:number_of_regions
            im_segmented(bounding_boxes(1,2,region_id):bounding_boxes(2,2,region_id), ...
                         bounding_boxes(1,1,region_id):bounding_boxes(2,1,region_id)) = 1;
        end
                                           
        encoded_proposed_pixels = rle_encoding(im_segmented);
        
        % LOSS FUNCTION
        
        err = err + 1 - loss_function(encoded_proposed_pixels, encoded_correct_pixels, im_size);
        
    end
    
    err = err ./ batch_size;
    
end

% function tf = hyst_constraint(X)
% 
%     tf = X.hyst_tl < X.hyst_th;
% 
% end