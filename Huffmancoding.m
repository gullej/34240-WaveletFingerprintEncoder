function [encodedseq,dict] = Huffmancoding(c,d,p)
% Firstly, put all the values in p into a sequence by using raster scan
% p is the coefficients after quantization
p_sequence = zeros(1,c*d);% c and d are the size of the input pic
j = 1;
for i = 1 : 64
    [a,b] = size(p{i});
    for i1 = 1 : a
        for j1 = 1 : b
              p_sequence(j) = p{i}(i1,j1);
              j = j + 1;
        end
    end
end

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

