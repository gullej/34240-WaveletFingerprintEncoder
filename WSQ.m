% Wavelet Scalar/Quantization
img = imread('DB1_B/110_8.tif');
subbands = subbandDecompose(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, 0.75);