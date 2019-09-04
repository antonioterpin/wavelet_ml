% Compression of the images in the dataset.

% Load global variables
globals();
global formatted_dataset_path images_path compressed_images column_image_id;

% Load dataset
opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path, opts);

number_of_images = size(dataset,1);
compression_dataset_waitbar = waitbar(0, 'Compressing dataset...'); % update waitbar
for i = 1 : number_of_images
    image_id = dataset{i,column_image_id}{1};
    % 1. Image to gray scale
    % Oss: they already are in gray scale, but they are saved as rgb
    I = imread(strcat(images_path, image_id));
    I = rgb2gray(I);
    imwrite(I, strcat(compressed_images, image_id));
    waitbar(i / number_of_images, compression_dataset_waitbar, 'Compressing dataset...'); % update waitbar
end
close(compression_dataset_waitbar); % close waitbar
