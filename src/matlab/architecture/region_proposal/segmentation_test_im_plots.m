function [loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params, ...
                                                        images, images_name, ...
                                                        images_high, images_high_name, ...
                                                        dataset, save_flag)

    if nargin==8
        save_flag = 0;
    end
                                                    
    % open image
    im = readimage(images,find(strcmp(images_name,im_name)));
    
    im_high = readimage(images_high,find(strcmp(images_high_name,im_name)));
    im_size = size(im);

    if class~= 0
    
        % load actual defect regions
        encoded_correct_pixels = cell2mat(dataset{strcmp(im_name,dataset{:,1}),class+1});

        % compute scores
        [loss_im, acc_im] = segmentation_test_im(im, encoded_correct_pixels, params, 1, im_high, save_flag);
        
    else
        
        [loss_im, acc_im] = segmentation_test_im(im, '', params, 1);
        
    end
    
    fprintf("im: %s loss: %.4f accuracy: %.4f\n", im_name, loss_im, acc_im);
    
end