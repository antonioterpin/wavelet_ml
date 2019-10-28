%% CONFIGURATION
segmentation_configuration


%% OPTIMIZATION
batch_size_opt = 150;
n_iter = 50;

% class 1;
% [results_1, params_1] = segmentation_optimization(images, dataset, 1, batch_size_opt, n_iter);

% class 2;
% [results_2, params_2] = segmentation_optimization(images, dataset, 2, batch_size_opt, n_iter);

% class 3;
% [results_3, params_3] = segmentation_optimization(images, dataset, 3, batch_size_opt, n_iter);

% class 4
% [results_4, params_4] = segmentation_optimization(images, dataset, 4, batch_size_opt, n_iter);


%% CUSTOM PARAMETERS
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
global results_segmentation_test_dir % export dir
batch_size_test = 1000;

% class 1;
params_1_file = '';
load(strcat(convertStringsToChars(results_segmentation_test_dir),params_1_file));
params_1 = params; clear('params');
% [loss_1, acc_1, test_data_1] = segmentation_test(images, dataset, 1, batch_size_test, params);

% class 2;
params_2_file = '';
load(strcat(convertStringsToChars(results_segmentation_test_dir),params_2_file));
params_2 = params; clear('params');
% [loss_2, acc_2, test_data_2] = segmentation_test(images, dataset, 2, batch_size_test, params);

% class 3;
params_3_file = '';
load(strcat(convertStringsToChars(results_segmentation_test_dir),params_3_file));
params_3 = params; clear('params');
% [loss_3, acc_3, test_data_3] = segmentation_test(images, dataset, 3, batch_size_test, params);

% class 4;
params_4_file = '';
load(strcat(convertStringsToChars(results_segmentation_test_dir),params_4_file));
params_4 = params; clear('params');
% [loss_4, acc_4, test_data_4] = segmentation_test(images, dataset, 4, batch_size_test, params);


%% TEST SINGLE IMAGE
class = 3;
im_name = '6d3f92952.jpg';

[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset)
