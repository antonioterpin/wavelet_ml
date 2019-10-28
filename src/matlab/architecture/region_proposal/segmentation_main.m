%% CONFIGURATION
segmentation_configuration


%% OPTIMIZATION
batch_size = 150;
n_iter = 50;

class = 3;
[results_3, params_3] = segmentation_optimization(images, dataset, class, batch_size, n_iter);

% class = 4;
% [results_4, params_4] = segmentation_optimization(images, dataset, class, batch_size, n_iter);

% class = 1;
% [results_1, params_1] = segmentation_optimization(images, dataset, class, batch_size, n_iter);


%% custom params
% params.kov_nscale = 5;
% params.kov_norient = 14;
% params.kov_min_wl = 4.8238;
% params.kov_mult = 1.668;
% params.hist_tl = 54;
% params.hist_th = 133;
% params.alpha = 7;
% params.hole_th = 8270;
% params.region_th = 672;


%% TEST
batch_size = 256;

% class = 3;
% [loss, acc, ~] = segmentation_test(images, dataset, class, batch_size, params);


%% TEST SINGLE IMAGE

% class
class = 3;
im_name = '6d3f92952.jpg';

[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset)
