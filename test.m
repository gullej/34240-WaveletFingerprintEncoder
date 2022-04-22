% Test of WSQ
close all; clearvars; clc;
img = imread('DB1_B/101_5.tif');

[encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = WSQ(img, 0.5);
img_hat = WSQinv(encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);

subplot(1,2,1);
imshow(img, [0 255]);
subplot(1,2,2);
imshow(img_hat,[0, 255]);

PSNR(double(img), img_hat);

(size(encodedseq,2)+8*size(byteneg,2)+8*size(bytepos,2)+8*size(byterun,2)+16*size(doubleneg,2)+16*size(doublepos,2)+16*size(doublerun,2))/(640*480*8)

