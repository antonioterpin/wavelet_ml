% Load global variables
globals();
global formatted_dataset_path images_path compressed_images column_image_id preprocessed_images;

% Load dataset
opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path, opts);

mkdir(compressed_images);
mkdir(preprocessed_images);

number_of_images = size(dataset,1);
processing_dataset_waitbar = waitbar(0, "Compressing dataset..."); % update waitbar
for i = 1 : number_of_images
    image_id = dataset{i,column_image_id}{1};
    % 1. Image to gray scale
    waitbar(i / number_of_images, processing_dataset_waitbar, sprintf("Compressing dataset... image %d of %d", i, number_of_images)); % update waitbar
    % Oss: they already are in gray scale, but they are saved as rgb
    I = imread(strcat(images_path, image_id));
    I = rgb2gray(I);
    imwrite(I, strcat(compressed_images, image_id));
    % 2. Histogram equalization
    waitbar(i / number_of_images, processing_dataset_waitbar, sprintf("Equalizing dataset... image %d of %d", i, number_of_images)); % update waitbar
    imwrite(histeq(I), strcat(preprocessed_images, image_id));
end
close(processing_dataset_waitbar); % close waitbar
