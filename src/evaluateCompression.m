function [psnr, mse, per, rate] = evaluateCompression(img, bpp)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = WSQ(img, bpp);
img_hat = WSQinv(encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);

[psnr, mse] = PSNR(double(img), img_hat);

per = (size(encodedseq,2)+8*size(byteneg,2)+8*size(bytepos,2)+8*size(byterun,2)+16*size(doubleneg,2)+16*size(doublepos,2)+16*size(doublerun,2))/(640*480*8);
rate = 1/per;

end

