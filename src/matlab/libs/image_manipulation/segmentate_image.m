function [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map)
% SEGMENTATE_IMAGE segment map of highlighted pixels into regions.
%       
%   [number_of_regions bounds bounding_boxes] = SEGMENTATE_IMAGE(map)
%
%   NUMBER_OF_REGIONS contains the number of regions found in the given map
%   SHAPE_MAP(:,:,region_id) contains the map of region identified by region_id
%   BOUNDING_BOXES(:,:,region_id) contains the bounding boxes of region identified by region_id
%
%   See also ALPHA_SHAPE, ALPHA_SHAPE
    
    % Alpha shaping
    pixels = rle_decoding(rle_encoding(map),size(map)); % just to re-use code.. can be improved
    shp = alphaShape(pixels(:,1),pixels(:,2));
    
    number_of_regions = numRegions(shp);
    % encoded_shape_map = zeros(1,number_of_regions);
    bounding_boxes = zeros(2,2,number_of_regions);
    encoded_shape_maps = [];
    
    % For each region
    for region_id = 1 : number_of_regions
        % calculate region bounds
        [~, b] = boundaryFacets(shp, region_id);
        % encoded_shape_map(region_id) = rle_encoding(b,size(map));
        encoded_shape_maps = [encoded_shape_maps; rle_encoding(b,size(map))];
        % calculate bounding boxes
        minX = min(b(:,1)); minY = min(b(:,2));
        maxX = max(b(:,1)); maxY = max(b(:,2));
        bounding_boxes(:,:,region_id) = [minX minY; maxX maxY];
    end
    
end