function globals
% GLOBALS Set all global variables.
%
% IMAGES
%   * images_path: contains the relative path to the original images.
%   * compressed_images: contains the relative path to the compressed images.
%   * defects_highlighted: contains the relative path to the images with highlighted defects.
%   * preprocessed_images: contains the relative path to the preprocessed images.
% 
% CSV
%   * dataset_path: contains the relative path to the original csv.
%   * formatted_dataset_path: contains the relative path to the formatted
%   csv.
%   * training_set_path: contains the relative path to the training set.
%   * cv_set_path: contains the relative path to the cross validation set.
%   * test_set_path: contains the relative path to the test set.
%
% NUMERIC
%   * number_defect_classes: contains the number of defect classes.
%
% DATASET COLUMNS NAME
%   * column_encoded_pixels: Name of encoded pixels column. Concat
%   '#class_id' to get the name of encoded pixels of that
%   class.
%   * column_image_id_class_id: Name of the column containing
%   image_id_class_id string. Image id is the name of the image while class
%   id is the number of the defect class.
%   * column_image_id: Name of the column of the image id in formatted
%   datasets.
%
% COLORS
%   * defects_colors: Array of colors for different defect classes


% IMAGES
global images_path compressed_images defects_highlighted preprocessed_images;

images_path = '../../data/images/';
compressed_images = '../../data/manipulated_images/compressed_images/';
defects_highlighted = '../../data/manipulated_images/defects_highlighted/';
preprocessed_images = '../../data/manipulated_images/preprocessed_images/';

% CSV
global dataset_path formatted_dataset_path training_set_path cv_set_path test_set_path;

dataset_path = '../../data/dataset.csv';
formatted_dataset_path = '../../data/manipulated_data/data_set.csv';
training_set_path = '../../data/manipulated_data/train_set.csv';
cv_set_path = '../../data/manipulated_data/cv_set.csv';
test_set_path = '../../data/manipulated_data/test_set.csv';

% NUMERIC
global number_defect_classes;

number_defect_classes = 4;

% DATASET COLUMNS NAME
global column_encoded_pixels column_image_id_class_id column_image_id;

column_encoded_pixels = 'EncodedPixels';
column_image_id_class_id = 'ImageId_ClassId';
column_image_id = 'ImageId';

% COLORS
global defects_colors;

defects_colors = ["red" "green" "blue" "yellow"];

end