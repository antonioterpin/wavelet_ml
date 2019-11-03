%% CONFIGURATION
segmentation_configuration

%% OPTIMIZATION
batch_size_opt = 128;
n_iter = 50;

% w/o equalization
% [results_1, params_1] = segmentation_optimization(images, dataset, 1, batch_size_opt, n_iter);
% [results_2, params_2] = segmentation_optimization(images, dataset, 2, batch_size_opt, n_iter);
% [results_3, params_3] = segmentation_optimization(images, dataset, 3, batch_size_opt, n_iter);
% [results_4, params_4] = segmentation_optimization(images, dataset, 4, batch_size_opt, n_iter);

% w/ equalization
% [results_eq_1, params_eq_1] = segmentation_optimization(images_eq, dataset, 1, batch_size_opt, n_iter);
% [results_eq_2, params_eq_2] = segmentation_optimization(images_eq, dataset, 2, batch_size_opt, n_iter);
% [results_eq_3, params_eq_3] = segmentation_optimization(images_eq, dataset, 3, batch_size_opt, n_iter);
% [results_eq_4, params_eq_4] = segmentation_optimization(images_eq, dataset, 4, batch_size_opt, n_iter);


%% TEST
batch_size_test = 1024;

% w/o equalization
% [loss_1, acc_1, test_data_1] = segmentation_test(images, dataset, 1, batch_size_test, params_1);
% [loss_2, acc_2, test_data_2] = segmentation_test(images, dataset, 2, 760, params_2);
% [loss_3, acc_3, test_data_3] = segmentation_test(images, dataset, 3, batch_size_test, params_3);
% [loss_4, acc_4, test_data_4] = segmentation_test(images, dataset, 4, batch_size_test, params_4);

% w/ equalization
% [loss_eq_1, acc_eq_1, test_data_eq_1] = segmentation_test(images_eq, dataset, 1, batch_size_test, params_eq_1);
% [loss_eq_2, acc_eq_2, test_data_eq_2] = segmentation_test(images_eq, dataset, 2, 760, params_eq_2);
% [loss_eq_3, acc_eq_3, test_data_eq_3] = segmentation_test(images_eq, dataset, 3, batch_size_test, params_eq_3);
% [loss_eq_4, acc_eq_4, test_data_eq_4] = segmentation_test(images_eq, dataset, 4, batch_size_test, params_eq_4);

