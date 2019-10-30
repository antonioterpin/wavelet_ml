function [loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params, ...
                                                        images, images_name, ...
                                                        images_high,images_high_name, ...
                                                        dataset)                                                    
% SEGMENTATION_TEST_IM_PLOTS Interface between segmentation_main and
% segmentation_test_im, used to fix parameters.

    % open image
    im = readimage(images,find(strcmp(images_name,im_name)));
    im_high = readimage(images_high,find(strcmp(images_high_name,im_name)));
    im_size = size(im);

    % load actual defect regions
    encoded_correct_pixels = cell2mat(dataset{strcmp(im_name,dataset{:,1}),class+1});

    % compute scores
    [loss_im, acc_im] = segmentation_test_im(im, encoded_correct_pixels, params, 1, im_high);
    
end