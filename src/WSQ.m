function [encodedseq,dict,Q, Z, a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = WSQ(img, bpp)
% Wavelet Scalar/Quantization

subbands = subbandDecompose(img);
[n, m] = size(img);
[p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subbands, bpp);
[v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p,n,m);
[encodedseq,dict] = huffmanEncode(n,m,v);

end
