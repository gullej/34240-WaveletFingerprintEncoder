function [encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = WSQ(img, bpp)
% Wavelet Scalar/Quantization

[n, m] = size(img);

subbands = subbandDecompose(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);
p_sequence = subbandUnfold(p,n,m);
[v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p_sequence);
[encodedseq,dict] = huffmanEncode(n,m,v);

end
