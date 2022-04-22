% Test of WSQ
close all; clearvars; clc;
img = imread('DB1_B/101_5.tif');
bpp = 1;

subbands = subbandDecompose(img);
[n, m] = size(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);
[v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p,n,m);
[encodedseq,dict] = huffmanEncode(n,m,v);

p_recover = huffmanDecode(encodedseq,dict,a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
subband_hat = subbandDequantize(p_recover,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);

subplot(1,2,1);
imshow(img, [0 255]);
subplot(1,2,2);
imshow(img_hat,[0, 255]);

[psnr, mse, per, rate] = evaluateCompression(img, bpp)
