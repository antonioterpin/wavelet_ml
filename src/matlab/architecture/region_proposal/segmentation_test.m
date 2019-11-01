function [loss, acc, test_data] = segmentation_test(images, dataset, class, batch_size, params)
% SEGMENTATION_TEST Test routine of the region proposal stage of the
% architecture.
%
%   [loss, acc, test_data] = segmentation_test(images, dataset, class, batch_size, params) launch
%   the test routine over kovesi-hysteretic edge detector and alpha shape pipeline.
%
%   * images:       is the image datastore
%   * dataset:      contains information about ideal segmentation
%   * class:        defect class
%   * batch_size:   optimization batch size
%   * n_iter:       number of iterations for epochs
%   * params:       segmentation parameters
%
%   See also SEGMENTATION_TEST_IM SEGMENTATION_OPTIMIZATION

    if class == 1
        class_str = '1000';
    elseif class == 2
        class_str = '0100';
    elseif class == 3
        class_str = '0010';
    elseif class == 4
        class_str = '0001';
    end
    
    global results_segmentation_test_dir
    file_log = convertStringsToChars(strcat(results_segmentation_test_dir,"log_class",num2str(class),"_batch",num2str(batch_size),sprintf("_%f",now),".out"));
    file_data = convertStringsToChars(strcat(results_segmentation_test_dir,"data_class",num2str(class),"_batch",num2str(batch_size),sprintf("_%f",now),".mat"));

    test_data = cell(batch_size,3);
    
    idx = find(images.Labels == class_str);
    s = RandStream('mlfg6331_64','Seed',0); 
    idx = sort(randsample(s,idx,batch_size,false));

    loss = 0;
    acc = 0;
     
    diary(file_log);
    
    fprintf("SEGMENTATION TEST STARTED\n");
    fprintf("class: %d\nbatch_size: %d\n\n", class, batch_size);
   
    test_waitbar = waitbar(0,'Calculating test results..');
    batch_size = length(idx);
    for n = 1 : batch_size
        
        waitbar(n / batch_size, test_waitbar, sprintf('Calculating test results... %d of %d',n, batch_size));
        
        i = idx(n);
        im = readimage(images,i);
        im_size = size(im);
        
        [~,name,ext] = fileparts(cell2mat(images.Files(i)));
        im_name = strcat(name,ext);
        
        fprintf("%2d) im: %s ", n, im_name);
        
        encoded_correct_pixels = cell2mat(dataset{strcmp(im_name,dataset{:,1}),class+1});
        
        [loss_i, acc_i] = segmentation_test_im(im, ...
                                               encoded_correct_pixels, ...
                                               params);
        
        fprintf("loss: %.3f acc: %.3f\n", loss_i, acc_i);
                                           
        loss = loss + 1 - loss_i;
        acc = acc + acc_i;
        
        test_data(n,:) = {im_name, loss, acc};
        
    end
    close(test_waitbar);
    
    loss = loss ./ batch_size;
    acc = acc ./ batch_size;
    
    fprintf("\navg_loss: %.3f\navg_acc:  %.3f\n", loss, acc);
    
    diary off;
    
    save(file_data, 'test_data');
    
end