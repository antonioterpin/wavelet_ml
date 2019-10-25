
% RISULTATI 24/10 classe 3 con batch da 5
%     hyst_tl    hyst_th    alpha    hole_th    region_th
%     _______    _______    _____    _______    _________
% 
%     44         99         7        577        2099     

% classe 3 con batch da 100 (best observed)
%     hyst_tl    hyst_th    alpha    hole_th    region_th
%     _______    _______    _____    _______    _________
% 
%     50         99         5        1639       512    
% Estimated objective function value = 0.71009
% Function evaluation time = 466.4164

% classe 3 con batch da 100 (best estimated)
%     hyst_tl    hyst_th    alpha    hole_th    region_th
%     _______    _______    _____    _______    _________
% 
%     48         100        5        670        510  
% Estimated objective function value = 0.71009
% Estimated function evaluation time = 481.5575

% im_name = '0adc17f1d.jpg'; %4
% im_name = '0b7a4c9b9.jpg'; %3
% im_name = '0be9bad7b.jpg'; %3-4
% im_name = '0d0c21687.jpg';
% im_name = '00e0398ad.jpg'; %3
% im_name = '2a8096ad1.jpg';
% im_name = '2b8dfbe0b.jpg'; %1
im_name = '2b15517b1.jpg'; %3
% im_name = '2bdb48c91.jpg'; %1
% im_name = '3a7d9b5c1.jpg'; %2

im = imread(strcat('test_images/',im_name));
im = rgb2gray(im);

im_high = imread(strcat('test_images/highligted/',im_name));

map = defect_edge_detection(im,49,196);
map(1:end,1) = 1;
map(1,1:end) = 1;
map(end, 1:end) = 1;
map(1:end, end) = 1;

[number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map, 19, 3992, 1674);

output1 = zeros(size(im)); output2 = zeros(size(im));
image_size = size(im);
x = 1:image_size(2); y = 1:image_size(1); [X,Y] = meshgrid(x,y);

for region_id = 1:number_of_regions
    color = floor(255 / number_of_regions) * region_id;
    
    filled_shape_feature = zeros(image_size(1)*image_size(2),1);
    filled_shape_feature(inShape(shp,X(:),Y(:),region_id)) = color;
    filled_shape_feature = reshape(filled_shape_feature, image_size(1), image_size(2));
    output1 = output1 + filled_shape_feature;
    % sprintf("%d-%d, %d-%d",bounding_boxes(1,1,region_id),bounding_boxes(1,2,region_id), ...
    %    bounding_boxes(2,1,region_id),bounding_boxes(2,2,region_id))
    
    output2(bounding_boxes(1,2,region_id):bounding_boxes(2,2,region_id), ...
        bounding_boxes(1,1,region_id):bounding_boxes(2,1,region_id)) = color;
end

figure; imshow(im_high);
figure; imshow(map);
figure('Position', [0 50 1600 256]); imagesc(output1);
figure('Position', [0 50 1600 256]); imagesc(output2);
    