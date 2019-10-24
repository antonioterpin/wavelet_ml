
im_name = '0adc17f1d.jpg'; %4
% im_name = '0b7a4c9b9.jpg'; %3
% im_name = '0be9bad7b.jpg'; %3-4
% im_name = '0d0c21687.jpg';
% im_name = '00e0398ad.jpg'; %3
% im_name = '2a8096ad1.jpg';
% im_name = '2b8dfbe0b.jpg'; %1
% im_name = '2b15517b1.jpg'; %3
% im_name = '2bdb48c91.jpg'; %1
% im_name = '3a7d9b5c1.jpg'; %2

im = imread(strcat('test_images/',im_name));
im_high = imread(strcat('test_images/highligted/',im_name));

M = phasecong3(im);
M_scaled = ( M - min(min(M)) ) ./ ( max(max(M)) - min(min(M)) ) .* 255;
% M_scaled = 1-M;
M_scaled_clean = hysthresh(M_scaled, 30, 70);
% M_scaled(M_scaled<60) = 0;

% map = M_scaled;
% map(map>0) = 1;

% [map_rle_str, map_rle] = rle_encoding(map);
% [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map);

figure; imshow(im_high);
figure; imshow(M_scaled);
figure; imshow(M_scaled_clean);