function [img_hat] = WSQinv(encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun)
%WSQing Summary of this function goes here
%   Detailed explanation goes here

decodedseq = huffmanDecode(encodedseq,dict);
p_hat = entropyDemap(decodedseq, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
p_recover = subbandFold(p_hat, a1, b1, a2, b2, a3, b3);
subband_hat = subbandDequantize(p_recover,Q,Z,a1,b1,a2,b2,a3,b3);
img_hat = subbandCompose(subband_hat);

end

