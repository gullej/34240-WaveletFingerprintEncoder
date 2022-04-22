% Test of WSQ
close all; clearvars; clc;
load('recover_pic.mat');
img = imread('DB1_B/101_5.tif');
bpp = 1;

%% Subband
subbands = subbandDecompose(img);
img_hat = subbandCompose(subbands);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat)

%% Quantize

[n, m] = size(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);
subband_hat = subbandDequantize(p,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat)

%% Unfold

p_sequence = subbandUnfold(subbands,n,m);
p_recover = subbandFold(p_sequence, a1, b1, a2, b2, a3, b3);
img_hat = subbandCompose(p_recover);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat)

%% Entropy Map

[v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p_sequence,n,m);
p_hat = entropyDemap(uint16(v), bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
p_recover = subbandFold(p_sequence, a1, b1, a2, b2, a3, b3);
img_hat = subbandCompose(p_recover);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat)

%% Huffman

[encodedseq,dict] = huffmanEncode(n,m,v);
decodedseq = huffmanDecode(encodedseq,dict);
p_hat = entropyDemap(decodedseq, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
p_recover = subbandFold(p_sequence, a1, b1, a2, b2, a3, b3);
img_hat = subbandCompose(p_recover);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat)

%%
[encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = WSQ(img, bpp);
img_hat = WSQinv(encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);

subplot(1,3,1);
imshow(img);
subplot(1,3,2);
imshow(uint8(img_hat));
subplot(1,3,3);
imshow(uint8(recover_pic));

[psnr, mse, per, rate] = evaluateCompression(img, bpp)
