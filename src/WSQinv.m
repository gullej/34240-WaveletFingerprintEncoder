function [img_hat] = WSQinv(encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun)
%WSQing Summary of this function goes here
%   Detailed explanation goes here
p_recover = huffmanDecode(encodedseq,dict,a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
subband_hat = subbandDequantize(p_recover,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = round(subbandCompose(subband_hat));

end

