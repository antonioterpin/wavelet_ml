% SEGMENTATION CONFIGURATION
                   
% dataset csv
global augmented_dataset_path
dataset = readtable(augmented_dataset_path,'Delimiter', ',');

% images
global global_feature_preprocessed_images global_feature_images
% w/o equalization
% images = imageDatastore(convertStringsToChars(global_feature_images),...
%                        'IncludeSubfolders', true,...
%                        'LabelSource', 'foldernames'); % use foldernames as labels
% w/ equalization
images = imageDatastore(convertStringsToChars(global_feature_preprocessed_images),...
                       'IncludeSubfolders', true,...
                       'LabelSource', 'foldernames'); % use foldernames as labels

% names of images
[~,name,ext] = cellfun(@fileparts,images.Files,'UniformOutput',false);
images_name = join([name ext],'');
clear('name','ext');

% highlighted images
global defects_highlighted
images_high = imageDatastore(convertStringsToChars(defects_highlighted),...
                            'IncludeSubfolders', true,...
                            'LabelSource', 'foldernames'); % use foldernames as labels
              
% names of highlighted images
[~,name,ext] = cellfun(@fileparts,images_high.Files,'UniformOutput',false);
images_high_name = join([name ext],'');
clear('name','ext');
