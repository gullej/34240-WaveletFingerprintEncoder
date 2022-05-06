% Test of WSQ
close all; clearvars; clc;
img = imread('DB1_B/102_3.tif');
bpp = 4;
[n, m] = size(img);

%% Subband

subbands = subbandDecompose(img);

img_hat = subbandCompose(subbands);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat);

%% Quantize

subbands = subbandDecompose(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);

subband_hat = subbandDequantize(p,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat);

%% Unfold

subbands = subbandDecompose(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);
p_sequence = subbandUnfold(p,n,m);

p_recover = subbandFold(p_sequence, a1, b1, a2, b2, a3, b3);
subband_hat = subbandDequantize(p_recover,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat);

%% Entropy Map

subbands = subbandDecompose(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);
p_sequence = subbandUnfold(p,n,m);
[v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p_sequence);

p_hat = entropyDemap(v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
p_recover = subbandFold(p_hat, a1, b1, a2, b2, a3, b3);
subband_hat = subbandDequantize(p_recover,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);


key = (p_hat ~= p_sequence);
temp1 = [p_sequence; p_hat];
temp2 = [p_sequence(key); p_hat(key)];
sum(p_hat<0)

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat);

%% Huffman

subbands = subbandDecompose(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);
p_sequence = subbandUnfold(p,n,m);
[v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p_sequence);
[encodedseq,dict] = huffmanEncode(n,m,v);

decodedseq = huffmanDecode(encodedseq,dict);
p_hat = entropyDemap(decodedseq, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
p_recover = subbandFold(p_hat, a1, b1, a2, b2, a3, b3);
subband_hat = subbandDequantize(p_recover,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);


key = (p_hat ~= p_sequence);
temp1 = [p_sequence; p_hat];
temp2 = [p_sequence(key); p_hat(key)];
sum(p_hat<0)

subplot(1,2,1);
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));

[psnr, mse] = PSNR(double(img), img_hat);


