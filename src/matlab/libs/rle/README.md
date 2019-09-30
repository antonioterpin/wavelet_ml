# RLE encoding/decoding of a binary matrix
This folder contains routines to encode and to decode binary matrices.
- rle_decoding.m is the routine to decode a binary matrix.
- rle_encoding.m is the routine to encode a binary matrix.
- rle.mlx is a matlab live script to briefly explain the above functions.

### RLE encoding
```
help rle_encoding;
[rle_encoded_pixels_string, rle_encoded_pixels] = rle_encoding(map);
[rle_encoded_pixels_string, rle_encoded_pixels] = rle_encoding(pixels, dim);
```
#### Examples
###### Example 1
The following given map:
```
        _         _
       | 0 1 0 1 1 |
 map = | 0 1 1 1 0 |  
       | 0 0 1 1 0 |
       | 0 0 1 0 0 |
        -         -
```
which contains the pixels ([x,y]):
```
pixels = [2 1; 2 2; 3 2; 3 3; 3 4; 4 1; 4 2; 4 3; 5 1]
```
Is vectorized as:
```
[0 0 0 0 1 1 0 0 0 1 1 1 1 1 1 0 1 0 0 0]
``` 
which is then encoded as:
```
rle_encoded_pixels_string = "5 2 10 6 17 1"
rle_encoded_pixels = [5 2 10 6 17 1]
```
###### Example 2
The list of pixels:
```
pixels = [2 1; 2 2; 3 2; 3 3; 3 4; 4 1; 4 2; 4 3; 5 1];
```
with 2D matrix dimensions:
```
dim = [4 5];
```
represents the map:
```
        _         _
       | 0 1 0 1 1 |
 map = | 0 1 1 1 0 |
       | 0 0 1 1 0 |
       | 0 0 1 0 0 |
        -         -
```
which is then encoded as the previous example.

### RLE decoding
```
help rle_decoding;
[pixels, map] = rle_decoding(rle_encoded_pixels_string, dim);
```
#### Examples
###### Example 1
'''
rle_encoded_pixels = "5 2 10 6 17 1"; 
dim = [4 5];
```
These data represents the following map:
```
        _         _
       | 0 1 0 1 1 |
 map = | 0 1 1 1 0 |  
       | 0 0 1 1 0 |  
       | 0 0 1 0 0 |
        -         -
```
which contains the pixels ([x,y]):
```
pixels = [2 1; 2 2; 3 2; 3 3; 3 4; 4 1; 4 2; 4 3; 5 1]
```