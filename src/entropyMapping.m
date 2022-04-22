function [outputVector, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMapping(p, n, m)


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

    if size(p_sequence, 1) ~= 1
        error('This must be a row vector.')
    end

    outputVector = [ ];
    
    bytepos = [];
    byteneg = [];
    byterun = [];
    doublepos = [];
    doubleneg = [];
    doublerun = [];

    count = 0;

    for i = 1:size(p_sequence, 2)

        if p_sequence(i) == 0
            count = count + 1;
        else
            if p_sequence(i) > 74
                if log2(p_sequence(i)) < 9
                    symbol = 101;
                    bytepos = [bytepos p_sequence(i)];
                else
                    symbol = 103;
                    doublepos = [doublepos uint16(p_sequence(i))];
                end
            elseif p_sequence(i) < -73
                if log2(p_sequence(i)*-1) < 9
                    symbol = 102;
                    byteneg = [byteneg -p_sequence(i)];
                else
                    symbol = 104;
                    doubleneg = [doubleneg uint16(-p_sequence(i))];
                end
            else
                symbol = 180+p_sequence(i);
            end
                
            if count == 0 
                outputVector = [outputVector symbol];
            else                   
                if count > 100
                    if log2(count) < 9
                        byterun = [byterun count];
                        count = 105;
                    else
                        doublerun = [doublerun count];
                        count = 106;
                    end
                end
                outputVector = [outputVector count symbol];
            end
            count = 0;
        end

    end

    if count ~= 0
        if count > 100
            if log2(count) < 9
                count = 105;
            else
                count = 106;
            end
         end
         outputVector = [outputVector count];
    end

end
