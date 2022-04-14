function [subband] = subbandDecompose(pic)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[LL,LH,HL,HH] = wsqTransform(pic);
[LL1,LH1,HL1,subband{52}] = wsqTransform(LL); % left up corner
[subband{53},subband{55},subband{54},subband{56}] = wsqTransform(HL);% right up corner
[subband{57},subband{59},subband{58},subband{60}] = wsqTransform(LH);% left buttom corner
[subband{61},subband{63},subband{62},subband{64}] = wsqTransform(HH);% right buttom corner

[LL1_lu,LL1_lb,LL1_ru,LL1_rb] = wsqTransform(LL1);
[HL1_lu,HL1_lb,HL1_ru,HL1_rb] = wsqTransform(HL1);
[LH1_lu,LH1_lb,LH1_ru,LH1_rb] = wsqTransform(LH1);

[LL1_lulu,subband{6},subband{5},subband{7}] = wsqTransform(LL1_lu);
[subband{12},subband{14},subband{13},subband{15}] = wsqTransform(LL1_lb);
[subband{8},subband{10},subband{9},subband{11}] = wsqTransform(LL1_ru);
[subband{16},subband{18},subband{17},subband{19}] = wsqTransform(LL1_rb);

[subband{36},subband{38},subband{37},subband{39}] = wsqTransform(HL1_lu);
[subband{44},subband{46},subband{45},subband{47}] = wsqTransform(HL1_lb);
[subband{40},subband{42},subband{41},subband{43}] = wsqTransform(HL1_ru);
[subband{48},subband{50},subband{49},subband{51}] = wsqTransform(HL1_rb);

[subband{20},subband{22},subband{21},subband{23}] = wsqTransform(LH1_lu);
[subband{28},subband{30},subband{29},subband{31}] = wsqTransform(LH1_lb);
[subband{24},subband{26},subband{25},subband{27}] = wsqTransform(LH1_ru);
[subband{32},subband{34},subband{33},subband{35}] = wsqTransform(LH1_rb);

[subband{1},subband{3},subband{2},subband{4}] = wsqTransform(LL1_lulu);

end

