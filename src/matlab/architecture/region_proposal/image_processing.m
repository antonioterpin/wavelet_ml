globals();
global formatted_dataset_path preprocessed_images; % data
global number_defect_classes; % data info
global column_image_id column_encoded_pixels; % columns

colormap('gray'); % because imshow is not convenient in this case so imagesc is used instead

% Load dataset
opts = detectImportOptions(formatted_dataset_path);
dataset = readtable(formatted_dataset_path , opts);

%%

% Load sample image
image_row = dataset(round(rand(1) * size(dataset,1)),:);
image_id = image_row{1,column_image_id}{1};
image = imread(sprintf("%s%s",preprocessed_images,image_id));

%%

map = zeros(size(image));
% Decode rle encoded pixels 
for class_id = 1 : number_defect_classes
    encoded_pixels = image_row{1,sprintf("%s%d",column_encoded_pixels,class_id)}{1};
    [~,pixels] = rle_decoding(encoded_pixels,size(image));
    map = map | pixels;
end

%%

figure;
subplot(2,1,1);
title("Image");
imagesc(image);
subplot(2,1,2);
title("Map");
imagesc(map * 255);

%%

if find(map ~= 0)
    [number_of_regions,encoded_shape_features,bounding_boxes] = segmentate_image(map);
    % Iterate over regions
    for region_id = 1 : number_of_regions
        [shape_feature, local_feature] = bounds2localfeature(...
            encoded_shape_features(region_id), ...
            bounding_boxes(:,:,region_id), image);
        % display shape feature
        figure;
        subplot(2,1,1);
        title(sprintf("Shape feature of region %d",region_id));
        imagesc(shape_feature)
        % display local feature
        subplot(2,1,2);
        title(sprintf("Local feature of region %d",region_id));
        imagesc(local_feature);
        colormap('gray');
    end
else
    "Flawless surface sampled."
end

%%

% Edge description - odd
edge_odd = zeros(100,600);
edge_odd(:, 1:250) = 1;
e = reshape(mod(1:100*100, 100), 100, 100)';
e(:,2:end) = e(:,1:end-1); e(:,1) = zeros(100,1);
edge_odd(:,251:350) = flip(e,2) / 100;
edge_odd = (edge_odd + 0.2) / 1.4;
imshow(edge_odd);

% Edge description - even
edge_even = zeros(100,600);
edge_even(:, 1:250) = 1; edge_even(:, 351:600) = 1;
e = reshape(mod(1:100*50, 50), 50, 100)';
e(:,2:end) = e(:,1:end-1); e(:,1) = zeros(100,1);
edge_even(:,251:300) = flip(e,2) / 50; edge_even(:,301:350) = e / 50;
edge_even = (edge_even + 0.2) / 1.4;
imshow(edge_even);

%%

I = rgb2gray(imread(strcat(images_path, 'ffb48ee43.jpg')));
figure;
imshow(I); % original image
figure('Position',[0 50 900 300]);
imhist(I); % original E[y] histogram
title('Histogram of luminance levels before equalization');
ylabel('Number of pixels');
xlabel('Luminance levels');
ylim([0 14000]);

%%

% Histogram equalization
Ieq = histeq(I);
figure;
imshow(Ieq); % result
figure('Position',[0 50 900 300]);
imhist(Ieq); % new E[y] histogram
title('Histogram of luminance levels after equalization');
ylabel('Number of pixels');
xlabel('Luminance levels');
ylim([0 14000]);