clc;clearvars;close all;
pic = double(imread('101_5.tif'));
j = 1;
for bpp = 3:8
    [a,b] = size(pic);
    %Decomposition
    subband = subbandDecompose(pic);
    %Quantization
    [p,Q,Z,a1,b1,a2,b2,a3,b3] = subbandQuantize(subband, bpp);
    %Unfold
    p_sequence = subbandUnfold(p,a,b);
    % Find the amount for each value - N is for the amount, edges for the edge of each slot
    %a = histogram(p_sequence);
    [N,edges] = histcounts(p_sequence,500000);%This 500000 is for seperating slots
    %Some of the slots are empty, get ride of them
    edges(N==0) = [];
    N(N==0)=[];
    %Trim our edges a bit, make it the same length as the N variable
    edges = edges + 1;
    edges = edges(1:length(N));
    % According to formula, here is the calculation
    H(j) = 0;
    for i = 1:length(N)
        H(j) = H(j) + (N(i)/sum(N)*log2(N(i)/sum(N)));
    end
    H(j) = -H(j); % Entropy for the image
    codelength(j) = H(j)*a*b;% estimated codelength(per pixel)
    [v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p_sequence);
    [encodedseq,dict] = huffmanEncode(a,b,v);
    len(j) = (size(encodedseq,2)+8*size(byteneg,2)+8*size(bytepos,2)+8*size(byterun,2)+16*size(doubleneg,2)+16*size(doublepos,2)+16*size(doublerun,2));
    bitperpixel(j) = len(j) / (a*b);
   codelength_diff(j) =  H(j) - bitperpixel(j);
    j = j + 1;
end
bpp = [3:8];
hold on
plot(bpp,bitperpixel);
plot(bpp,H);
hold off
xlabel('Quantization level') ;
ylabel('Entropy') ;
legend('Bit per Pixel','Estimated Entropy');
