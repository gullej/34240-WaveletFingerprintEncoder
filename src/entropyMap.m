function [v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun] = entropyMap(p_sequence)

    if size(p_sequence, 1) ~= 1
        error('This must be a row vector.')
    end

    v = [];
    
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
                    doublepos = [doublepos double(uint16(p_sequence(i)))];
                end
            elseif p_sequence(i) < -73
                if log2(p_sequence(i)*-1) < 9
                    symbol = 102;
                    byteneg = [byteneg (-1)*p_sequence(i)];
                else
                    symbol = 104;
                    doubleneg = [doubleneg double(uint16((-1)*p_sequence(i)))];
                end
            else
                symbol = 180+p_sequence(i);
            end
                
            if count == 0 
                v = [v symbol];
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
                v = [v count symbol];
            end
            count = 0;
        end

    end

    if count ~= 0
        if count > 100
            if log2(count) < 9
                byterun = [byterun count];
                count = 105;
            else
                doublerun = [doublerun count];
                count = 106;
            end
         end
         v = double([v count]);
    end

end
