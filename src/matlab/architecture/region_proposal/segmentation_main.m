%% CONFIGURATION
segmentation_configuration

%% OPTIMIZATION
batch_size = 1;
n_iter = 2;

% class = 3;
% results_3 = segmentation_optimization(images, dataset, class, batch_size, n_iter
% params = table2struct(results_3.XAtMinObjective);

class = 4;
[results_4, params_4] = segmentation_optimization(images, dataset, class, batch_size, n_iter);

% global results_segmentation_optimization_dir
% params = table2struct(results_3.XAtMinObjective);
% save(strcat(convertStringsToChars(results_segmentation_optimization_dir),'results_3_',datestr(now)), 'results_3');

%%
params.kov_nscale = 5;
params.kov_norient = 14;
params.kov_min_wl = 4.8238;
params.kov_mult = 1.668;
params.hist_tl = 54;
params.hist_th = 133;
params.alpha = 7;
params.hole_th = 8270;
params.region_th = 672;


%% TEST
class = 3;
batch_size = 5;
[loss, acc, ~] = segmentation_test(images, dataset, class, batch_size, params);


%% TEST SINGLE IMAGE

% class
class = 3;
im_name = '6d3f92952.jpg';

[loss_im, acc_im] = segmentation_test_im_plots(im_name, class, params, ...
                                               images, images_name, ...
                                               images_high, images_high_name, ...
                                               dataset)
                               

                                           
                                           
                                           
                                           
                                           
                                           
                                           
                                           
% test images (in test_images)
% im_name = '0d0c21687.jpg';
% im_name = '2a8096ad1.jpg';
% im_name = '2b8dfbe0b.jpg'; %1
% im_name = '2bdb48c91.jpg'; %1
% im_name = '3a7d9b5c1.jpg'; %2
% im_name = '00e0398ad.jpg'; %3
% im_name = '0b7a4c9b9.jpg'; %3
% im_name = '2b15517b1.jpg'; %3 ------->
% im_name = '091d21109.jpg'; %3
% im_name = '92e4102b4.jpg'; %3
% im_name = '92ebbbaea.jpg'; %3
% im_name = '93f27e439.jpg'; %3
% im_name = '0be9bad7b.jpg'; %3-4
% im_name = '097eaf94c.jpg'; %3-4
% im_name = '0adc17f1d.jpg'; %4
% im_name = '180bb19f9.jpg'; %4
% im_name = 'd80d59653.jpg'; %4
% im_name = 'db5dd1ed3.jpg'; %4
% im_name = 'dc94faafc.jpg'; %4

% im = imread(strcat('test_images/',im_name));
% im_high = imread(strcat('test_images/highligted/',im_name));