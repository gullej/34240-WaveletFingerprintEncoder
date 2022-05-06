% Test of WSQ
close all; clearvars; clc;

img = imread('DB1_B/102_3.tif');
bpp = 4;
[n, m] = size(img);

[encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = WSQ(img, bpp);
img_hat = WSQinv(encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
[psnr, mse, per, rate] = evaluateCompression(img, bpp);

txt = {sprintf('PSNR: %.3f',psnr),sprintf('MSE: %.3f',mse),sprintf('Compression rate: %.3f',rate)};

subplot(1,2,1)
imshow(img);
subplot(1,2,2);
imshow(uint8(img_hat));
text(-200, 600, txt)