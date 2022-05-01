function [p] = entropyDemap(v, bytepos, byteneg, doublepos, doubleneg, byterun, doublerun)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 p = [];
 byteposcnt = 1;
 bytenegcnt = 1;
 byteruncnt = 1;
 doubleposcnt = 1;
 doublenegcnt = 1;
 doubleruncnt = 1;

    for i = 1:size(v, 2)
        temp = v(i);
        if (temp < 101 && temp > 0)
            p = [p zeros(1,temp)];
        elseif temp == 101
            p = [p bytepos(byteposcnt)];
            byteposcnt = byteposcnt + 1;
        elseif temp == 102
            p = [p (-1)*byteneg(bytenegcnt)];
            bytenegcnt = bytenegcnt + 1;
        elseif temp == 103
            p = [p doublepos(doubleposcnt)];
            doubleposcnt = doubleposcnt + 1;
        elseif temp == 104
            p = [p (-1)*doubleneg(doublenegcnt)];
            doublenegcnt = doublenegcnt + 1;
        elseif temp == 105
            p = [p zeros(1,byterun(byteruncnt))];
            byteruncnt = byteruncnt + 1;
        elseif temp == 106
            p = [p zeros(1,doublerun(doubleruncnt))];
            doubleruncnt = doubleruncnt + 1;
        else
            p = [p temp-180];
        end
        
    end

    p = double(p);
end

