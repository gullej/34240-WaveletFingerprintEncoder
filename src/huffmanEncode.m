function [encodedseq,dict] = huffmanEncode(c,d,p_sequence)
% Firstly, put all the values in p into a sequence by using raster scan
% p is the coefficients after quantization


uni = unique(p_sequence); % Get all the unique values from p_sequence

for i = 1:length(uni)
    count = find(p_sequence == uni(i));
    sumcount = sum(count);
    frequency(i) = sumcount/length(p_sequence); % count frequency for each unique value
end
% sum all the frequencies
freq_sum = sum(frequency) ;
% calculate the frequency of each pixel
probability = frequency ./ freq_sum ;
% create a dictionary
dict = huffmandict(uni,probability);
% encoding
encodedseq = huffmanenco(p_sequence,dict);
end

