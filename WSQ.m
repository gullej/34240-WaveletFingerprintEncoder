% Wavelet Scalar/Quantization
close all; clearvars; clc;

img = imread('DB1_B/110_8.tif');
subbands = subbandDecompose(img);
[n, m] = size(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, 0.75);
v = entropyMapping(p,n,m);
[encodedseq,dict] = huffmanEncode(n,m,v);