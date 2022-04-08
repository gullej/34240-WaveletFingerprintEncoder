function [LL1_lululu,LL1_lululb,LL1_luluru,LL1_lulurb, LH1_rblu,LH1_rblb, ...
            LH1_rbru,LH1_rbrb, LH1_rulu,LH1_rulb,LH1_ruru,LH1_rurb, LH1_lblu, ...
            LH1_lblb,LH1_lbru,LH1_lbrb, LH1_lulu,LH1_lulb,LH1_luru,LH1_lurb, ...
            HL1_rblu,HL1_rblb,HL1_rbru,HL1_rbrb,HL1_rulu,HL1_rulb,HL1_ruru,HL1_rurb,...
            HL1_lblu,HL1_lblb,HL1_lbru,HL1_lbrb,HL1_lulu,HL1_lulb,HL1_luru,HL1_lurb,...
            LL1_rblu,LL1_rblb,LL1_rbru,LL1_rbrb,LL1_rulu,LL1_rulb,LL1_ruru,LL1_rurb,...
            LL1_lblu,LL1_lblb,LL1_lbru,LL1_lbrb,LL1_lulb,LL1_luru,LL1_lurb,...
            LL4,LH4,HL4,HH4,LL3,LH3,HL3,HH3,LL2,LH2,HL2,HH2,HH1] = subbandDecompose(pic)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[LL,LH,HL,HH] = wsqTransform(pic);
[LL1,LH1,HL1,HH1] = wsqTransform(LL); % left up corner
[LL2,LH2,HL2,HH2] = wsqTransform(HL);% right up corner
[LL3,LH3,HL3,HH3] = wsqTransform(LH);% left buttom corner
[LL4,LH4,HL4,HH4] = wsqTransform(HH);% right buttom corner

[LL1_lu,LL1_lb,LL1_ru,LL1_rb] = wsqTransform(LL1);
[HL1_lu,HL1_lb,HL1_ru,HL1_rb] = wsqTransform(HL1);
[LH1_lu,LH1_lb,LH1_ru,LH1_rb] = wsqTransform(LH1);

[LL1_lulu,LL1_lulb,LL1_luru,LL1_lurb] = wsqTransform(LL1_lu);
[LL1_lblu,LL1_lblb,LL1_lbru,LL1_lbrb] = wsqTransform(LL1_lb);
[LL1_rulu,LL1_rulb,LL1_ruru,LL1_rurb] = wsqTransform(LL1_ru);
[LL1_rblu,LL1_rblb,LL1_rbru,LL1_rbrb] = wsqTransform(LL1_rb);

[HL1_lulu,HL1_lulb,HL1_luru,HL1_lurb] = wsqTransform(HL1_lu);
[HL1_lblu,HL1_lblb,HL1_lbru,HL1_lbrb] = wsqTransform(HL1_lb);
[HL1_rulu,HL1_rulb,HL1_ruru,HL1_rurb] = wsqTransform(HL1_ru);
[HL1_rblu,HL1_rblb,HL1_rbru,HL1_rbrb] = wsqTransform(HL1_rb);

[LH1_lulu,LH1_lulb,LH1_luru,LH1_lurb] = wsqTransform(LH1_lu);
[LH1_lblu,LH1_lblb,LH1_lbru,LH1_lbrb] = wsqTransform(LH1_lb);
[LH1_rulu,LH1_rulb,LH1_ruru,LH1_rurb] = wsqTransform(LH1_ru);
[LH1_rblu,LH1_rblb,LH1_rbru,LH1_rbrb] = wsqTransform(LH1_rb);

[LL1_lululu,LL1_lululb,LL1_luluru,LL1_lulurb] = wsqTransform(LL1_lulu);

end

