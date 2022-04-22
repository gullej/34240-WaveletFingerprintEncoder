function [p_sequence] = subbandUnfold(p,n,m)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
p_sequence = zeros(1,n*m);% c and d are the size of the input pic
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

end

