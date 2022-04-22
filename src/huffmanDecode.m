function [p_recover] = huffmanDecode(encodedseq,dict,a1,b1,a2,b2,a3,b3,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun)
decodedseq = huffmandeco(encodedseq,dict);
decodedseq = entropyDemap(decodedseq,bytepos, byteneg, doublepos, doubleneg, byterun, doublerun);
decodedseq = [decodedseq zeros(1,288773)];
count = 1;
for i = 1:4
    for i1 = 1:a1
        for j1 = 1:b1
            p_recover{i}(i1,j1) = decodedseq(count);
            count = count + 1;
        end
    end
end
for i = 5:51
   for i1 = 1:a2
        for j1 = 1:b2
            p_recover{i}(i1,j1) = decodedseq(count);
            count = count + 1;
        end
    end
end
for i = 52:64
   for i1 = 1:a3
        for j1 = 1:b3
            p_recover{i}(i1,j1) = decodedseq(count);
            count = count + 1;
        end
    end
end
end

