function globals
% GLOBALS Set all global variables.
%
% IMAGES
%   * images_path: contains the relative path to the original images.
%   * compressed_images: contains the relative path to the compressed images.
%   * defects_highlighted: contains the relative path to the images with highlighted defects.
%   * preprocessed_images: contains the relative path to the preprocessed images.
%   * shape_feature_images: contains the relative path to the shape feature
%   images
%   * local_feature_images: contains the relative path to the local feature
%   images
% 
% CSV
%   * dataset_path: contains the relative path to the original csv.
%   * formatted_dataset_path: contains the relative path to the formatted
%   csv.
%   * augmented_dataset_path: contains the relative path to the augmented
%   dataset
%   * training_set_path: contains the relative path to the training set.
%   * cv_set_path: contains the relative path to the cross validation set.
%   * test_set_path: contains the relative path to the test set.
%   * classification_training_set_path: contains relative path to
%   classification training set
%   * classification_test_set_path: contains relative path to
%   classification test set
%   * classification_cv_set_path: contains relative path to
%   classification cross validation set
%
% NUMERIC
%   * number_defect_classes: contains the number of defect classes.
%   * image_size: array of image_size
%   * minimum_defective_area: minimum defective area value
%
% DATASET COLUMNS NAME
%   * column_encoded_pixels: Name of encoded pixels column. Concat
%   "#class_id" to get the name of encoded pixels of that
%   class.
%   * column_image_id_class_id: Name of the column containing
%   image_id_class_id string. Image id is the name of the image while class
%   id is the number of the defect class.
%   * column_image_id: Name of the column of the image id in formatted
%   datasets.
%
% COLORS
%   * defects_colors: Array of colors for different defect classes
%
% EXPORTS
%   * variables_analytics_defects_statistics_path: Path to defects
%   statistics saved variables.
%   * variables_shape_imds_path: Path to shape imds variables for mc-cnn training.
%   * variables_local_imds_path: Path to local imds variables for mc-cnn training.
%   * variables_shape_sbs_imds_path: Path to shape subsets imds variables for mc-cnn training.
%   * variables_local_sbs_imds_path: Path to local subsets imds variables for mc-cnn training.


% IMAGES
global images_path compressed_images defects_highlighted preprocessed_images shape_feature_images local_feature_images;

images_path = "../../data/images/";
compressed_images = "../../data/manipulated-images/compressed-images/";
defects_highlighted = "../../data/manipulated-images/defects-highlighted/";
preprocessed_images = "../../data/manipulated-images/preprocessed-images/";
shape_feature_images = "../../data/ideal-mc-cnn/shape-features/";
local_feature_images = "../../data/ideal-mc-cnn/local-features/";

% CSV
global dataset_path formatted_dataset_path augmented_dataset_path... 
    training_set_path cv_set_path test_set_path...
    classification_training_set_path classification_test_set_path classification_cv_set_path;

dataset_path = "../../data/dataset.csv";
formatted_dataset_path = "../../data/manipulated-data/dataset.csv";
training_set_path = "../../data/manipulated-data/train-set.csv";
cv_set_path = "../../data/manipulated-data/cv-set.csv";
test_set_path = "../../data/manipulated-data/test-set.csv";
augmented_dataset_path = "../../data/manipulated-data/augmented-dataset.csv";
classification_training_set_path = "../../data/ideal-mc-cnn/training.csv";
classification_test_set_path = "../../data/ideal-mc-cnn/test.csv";
classification_cv_set_path = "../../data/ideal-mc-cnn/cv.csv";

% NUMERIC
global number_defect_classes image_size minimum_defective_area;

number_defect_classes = 4;
image_size = [256 1600];
minimum_defective_area = 0; % Eventually set this

% DATASET COLUMNS NAME
global column_encoded_pixels column_image_id_class_id column_image_id column_defect_class;

column_encoded_pixels = "EncodedPixels";
column_image_id_class_id = "ImageId_ClassId";
column_image_id = "ImageId";
column_defect_class = "DefectClass";

% COLORS
global defects_colors;

defects_colors = ["red" "green" "blue" "yellow"];

% EXPORTS
global variables_analytics_defects_statistics_path;
global variables_shape_imds_path variables_local_imds_path variables_shape_sbs_imds_path variables_local_sbs_imds_path;

variables_analytics_defects_statistics_path = "../../data/exports/defect-analysis/defects-statistics.mat";
variables_shape_imds_path = "../../data/exports/mc-cnn/data/shape-imds.mat";
variables_local_imds_path = "../../data/exports/mc-cnn/data/local-imds.mat";
variables_shape_sbs_imds_path = "../../data/exports/mc-cnn/data/shape-sbs-imds.mat";
variables_local_sbs_imds_path = "../../data/exports/mc-cnn/data/local-sbs-imds.mat";

end