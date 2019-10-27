% classe
class = 3;

% test images
% im_name = '0d0c21687.jpg';
% im_name = '2a8096ad1.jpg';
% im_name = '2b8dfbe0b.jpg'; %1
% im_name = '2bdb48c91.jpg'; %1
% im_name = '3a7d9b5c1.jpg'; %2
% im_name = '00e0398ad.jpg'; %3
% im_name = '0b7a4c9b9.jpg'; %3
% im_name = '2b15517b1.jpg'; %3 ------->
% im_name = '091d21109.jpg'; %3
im_name = '92e4102b4.jpg'; %3
% im_name = '92ebbbaea.jpg'; %3
% im_name = '93f27e439.jpg'; %3
% im_name = '0be9bad7b.jpg'; %3-4
% im_name = '097eaf94c.jpg'; %3-4
% im_name = '0adc17f1d.jpg'; %4
% im_name = '180bb19f9.jpg'; %4
% im_name = 'd80d59653.jpg'; %4
% im_name = 'db5dd1ed3.jpg'; %4
% im_name = 'dc94faafc.jpg'; %4

im = imread(strcat('test_images/',im_name));
% im = rgb2gray(im);
im_high = imread(strcat('test_images/highligted/',im_name));

% dataset images
% global global_feature_images
% images = imageDatastore(convertStringsToChars(global_feature_images),...
%          'IncludeSubfolders', true, 'LabelSource', 'foldernames'); % use foldernames as labels

% dataset csv
global augmented_dataset_path
dataset = readtable(augmented_dataset_path,'Delimiter', ',');
        
% ACTUAL REGIONS
encoded_correct_pixels = cell2mat(dataset{find(strcmp(im_name,dataset{:,1})),class+1});

% SCORES
[loss, acc] = segmentation_test(im, im_high, encoded_correct_pixels, 5, 14, 4.8238, 1.668, 54, 133, 7, 8270, 672);

loss
acc