% Wavelet Scalar/Quantization
close all; clearvars; clc;

img = imread('DB1_B/101_5.tif');
subbands = subbandDecompose(img);
[n, m] = size(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, 0.1);
subband_hat = subbandDequantize(p,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);


subplot(1,2,1);
imshow(img, [0 255]);
subplot(1,2,2);
imshow(img_hat,[0, 255])

[v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMapping(p,n,m);
[encodedseq,dict] = huffmanEncode(n,m,v);

(size(encodedseq,2)+8*size(byteneg,2)+8*size(bytepos,2)+8*size(byterun,2)+16*size(doubleneg,2)+16*size(doublepos,2)+16*size(doublerun,2))/(n*m*8)