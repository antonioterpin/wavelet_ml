globals();

global augmented_dataset_path; % data

% Load dataset
opts = detectImportOptions(augmented_dataset_path);
dataset = readtable(augmented_dataset_path, opts);

%%

% Save local, shape and global features to class folders
ds2class_folders(dataset);

%%

global shape_feature_images local_feature_images global_feature_images;
global global_feature_preprocessed_images local_feature_preprocessed_images;

% Create imds
shape_imds = imageDatastore(shape_feature_images,...
    "IncludeSubfolders", true, "LabelSource", "foldernames"); % use foldernames as labels
local_imds = imageDatastore(local_feature_images,...
            "IncludeSubfolders", true, "LabelSource", "foldernames"); % use foldernames as labels
local_preprocessed_imds = imageDatastore(local_feature_preprocessed_images,...
            "IncludeSubfolders", true, "LabelSource", "foldernames"); % use foldernames as labels
global_imds = imageDatastore(global_feature_images,...
            "IncludeSubfolders", true, "LabelSource", "foldernames"); % use foldernames as labels
global_preprocessed_imds = imageDatastore(global_feature_preprocessed_images,...
    "IncludeSubfolders", true, "LabelSource", "foldernames"); % use foldernames as labels

% dataset subset         
div_proportions = [0.9 0.07];
% split shape imds
shape_imds = shuffle(shape_imds);
[shape_train_imds, shape_cv_imds, shape_test_imds] = splitEachLabel(shape_imds, div_proportions(1), div_proportions(2));
% split local imds
local_imds = shuffle(local_imds);
[local_train_imds, local_cv_imds, local_test_imds] = splitEachLabel(local_imds, div_proportions(1), div_proportions(2));
local_preprocessed_imds = shuffle(local_preprocessed_imds);
[local_prepr_train_imds, local_prepr_cv_imds, local_prepr_test_imds] = splitEachLabel(local_preprocessed_imds, div_proportions(1), div_proportions(2));
% split global imds
% Threshold on global categories
threshold = 750;
labels_count = countEachLabel(global_imds);
labels_to_keep = labels_count(labels_count{:,2} > threshold,1);
global_reduced_imds = subset(global_imds,~isundefined(categorical(global_imds.Labels, labels_to_keep{:,1})));
global_prepr_reduced_imds = subset(global_imds,~isundefined(categorical(global_imds.Labels, labels_to_keep{:,1})));

global_reduced_imds = shuffle(global_reduced_imds);
[global_train_imds, global_cv_imds, global_test_imds] = splitEachLabel(global_reduced_imds, div_proportions(1), div_proportions(2));
global_preprocessed_imds = shuffle(global_preprocessed_imds);
[global_prepr_train_imds, global_prepr_cv_imds, global_prepr_test_imds] = splitEachLabel(global_prepr_reduced_imds, div_proportions(1), div_proportions(2));

% save imds on export variable
global variables_shape_imds_path variables_local_imds_path variables_global_imds_path;

save(variables_shape_imds_path, "shape_imds", "shape_train_imds", "shape_cv_imds", "shape_test_imds");
save(variables_local_imds_path, "local_imds", "local_train_imds", "local_cv_imds", "local_test_imds",...
    "local_preprocessed_imds", "local_prepr_train_imds", "local_prepr_cv_imds", "local_prepr_test_imds");
save(variables_global_imds_path, "global_imds", "global_reduced_imds", "global_train_imds", "global_cv_imds", "global_test_imds",...
    "global_preprocessed_imds", "global_prepr_reduced_imds", "global_prepr_train_imds", "global_prepr_cv_imds", "global_prepr_test_imds");

%%

% train subset imds
train_counts = countEachLabel(local_train_imds);
n_labels_train = min(train_counts.Count);
shape_sbs_train_imds = splitEachLabel(shape_train_imds, n_labels_train);
local_sbs_train_imds = splitEachLabel(local_train_imds, n_labels_train);
local_prepr_sbs_train_imds = splitEachLabel(local_prepr_train_imds, n_labels_train);
    % global
train_counts_global = countEachLabel(global_train_imds);
n_labels_train_global = min(train_counts_global.Count);
global_sbs_train_imds = splitEachLabel(global_train_imds, n_labels_train_global);
global_prepr_sbs_train_imds = splitEachLabel(global_prepr_train_imds, n_labels_train_global);

% cross validation subset imds
cv_counts = countEachLabel(local_cv_imds);
n_labels_cv = min(cv_counts.Count);
shape_sbs_cv_imds = splitEachLabel(shape_cv_imds, n_labels_cv);
local_sbs_cv_imds = splitEachLabel(local_cv_imds, n_labels_cv);
local_prepr_sbs_cv_imds = splitEachLabel(local_prepr_cv_imds, n_labels_cv);
    % global
cv_counts_global = countEachLabel(global_cv_imds);
n_labels_cv_global = min(cv_counts_global.Count);
global_sbs_cv_imds = splitEachLabel(global_cv_imds, n_labels_cv_global);
global_prepr_sbs_cv_imds = splitEachLabel(global_prepr_cv_imds, n_labels_cv_global);

% test subset imds
test_counts = countEachLabel(local_test_imds);
n_labels_test = min(test_counts.Count);
shape_sbs_test_imds = splitEachLabel(shape_test_imds, n_labels_test);
local_sbs_test_imds = splitEachLabel(local_test_imds, n_labels_test);
local_prepr_sbs_test_imds = splitEachLabel(local_prepr_test_imds, n_labels_test);
    % global
test_counts_global = countEachLabel(global_test_imds);
n_labels_test_global = min(test_counts_global.Count);
global_sbs_test_imds = splitEachLabel(global_test_imds, n_labels_test_global);
global_prepr_sbs_test_imds = splitEachLabel(global_prepr_test_imds, n_labels_test_global);

% save sbs imds on export variable
global variables_shape_sbs_imds_path variables_local_sbs_imds_path variables_global_sbs_imds_path;

save(variables_shape_sbs_imds_path, "shape_sbs_train_imds", "shape_sbs_cv_imds", "shape_sbs_test_imds");
save(variables_local_sbs_imds_path, "local_sbs_train_imds", "local_sbs_cv_imds", "local_sbs_test_imds", ...
    "local_prepr_sbs_train_imds", "local_prepr_sbs_cv_imds", "local_prepr_sbs_test_imds");
save(variables_global_sbs_imds_path, "global_sbs_train_imds", "global_sbs_cv_imds", "global_sbs_test_imds",...
    "global_prepr_sbs_train_imds", "global_prepr_sbs_cv_imds", "global_prepr_sbs_test_imds");

%%

% Train mc-cnn columns
shape_net = train_column(shape_sbs_train_imds, shape_sbs_test_imds, structure_shape_column());
save("net", "shape_net");
local_net = train_column(local_sbs_train_imds, local_sbs_test_imds, structure_local_column());
save("net", "shape_net", "local_net");
local_prepr_net = train_column(local_prepr_train_imds, local_prepr_test_imds, structure_local_column());
save("net", "shape_net", "local_net", "local_prepr_net");
global_net = train_column(global_sbs_train_imds, global_sbs_test_imds, structure_global_column());
save("net", "shape_net", "local_net", "local_prepr_net", "global_net");
global_prepr_net = train_column(global_prepr_train_imds, global_prepr_test_imds, structure_global_column());
save("net", "shape_net", "local_net", "local_prepr_net", "global_net", "global_prepr_net");

%%

% on training set
[Y_pred_train_local, train_scores_local] = classify(local_net, local_sbs_train_imds); % Local column

% on test set
[Y_pred_test_local, test_scores_local] = classify(local_net, local_sbs_test_imds); % Local column

plotconfusion(Y_pred_test_local,local_sbs_test_imds.Labels);