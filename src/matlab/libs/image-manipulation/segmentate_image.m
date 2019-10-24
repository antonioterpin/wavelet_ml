function [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map, alpha, hole_th, region_th)
% SEGMENTATE_IMAGE segment binary matrix into regions of interest.
%       
%   [number_of_regions, encoded_shape_maps, bounding_boxes, shp] = segmentate_image(map)
%   Given a binary matrix describing interesting points, this use an alpha
%   shape (shp) to segmentate it in region of interest. The number of these
%   regions is given in number_of_regions. For each of these regions, an
%   encoded shape map describing its border can be found in
%   encoded_shape_maps(region_id), and its bounding box, described by
%   top-left and bottom-right coordinates, is given in
%   bounding_boxes(:,:,region_id). region_id is a number between 1 and
%   number_of_regions, inclusive.
%
%   [_] = segmentate_image(_, alpha, hole_th, region_th) Parametric alpha shaping.
%
%   Example:
%
%   In the map below:
%          _           _
%         | 0 1 0 0 0 0 |
%   map = | 1 1 1 0 1 1 |
%         | 0 1 0 0 1 1 |
%          -           -
%   there are two regions:
%
%                Region 1                                   Region 2
%   encoded_shape_maps(1) = "2 1 4 1 6 1 8 1"   encoded_shape_maps(2) = "14 2 17 2"
%                            _   _                                       _   _
%                           | 1 1 |                                     | 5 2 |
%   bounding_boxes(:,:,1) = | 3 3 |             bounding_boxes(:,:,1) = | 6 3 |
%                            -   -                                       -   -
%                                            _         _
%                                           | minX minY |
%   Remark: bounding_boxes(:,:,region_id) = | maxX maxY |
%                                            -         -
%   Remark: observe that the encoded shape is not the encoded region.
%   Instead its border is encoded:
%              _           _
%             | 0 1 0 0 0 0 |
%   borders = | 1 0 1 0 1 1 |
%             | 0 1 0 0 1 1 |
%              -           -
%
%   Possible further development: a lower bound to areas might be
%   introduced
%
%   See also ALPHA_SHAPE, RLE_ENCODING, RLE_DECODING

    if nargin < 4
        region_th = 0;
    end
    if nargin < 3
        hole_th = 0;
    end
    if nargin < 2
        alpha = 0.7;
    end
    
    % Alpha shaping
    pixels = rle_decoding(rle_encoding(map),size(map)); % just to re-use code.. can be improved
    shp = alphaShape(pixels(:,1),pixels(:,2), ...
        alpha, "HoleThreshold", hole_th, "RegionThreshold", region_th);

    number_of_regions = numRegions(shp);
    encoded_shape_maps = string(zeros(1,number_of_regions));
    bounding_boxes = zeros(2,2,number_of_regions);
    
    % For each region
    for region_id = 1 : number_of_regions % number_of_all_regions
        % calculate region bounds
        [~, b] = boundaryFacets(shp, region_id);
        encoded_shape_maps(region_id) = rle_encoding(b,size(map));
        % calculate bounding boxes
        minX = min(b(:,1)); minY = min(b(:,2));
        maxX = max(b(:,1)); maxY = max(b(:,2));
        bounding_boxes(:,:,region_id) = [minX minY; maxX maxY];
    end
    
end