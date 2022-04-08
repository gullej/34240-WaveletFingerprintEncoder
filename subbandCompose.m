% This code is for the last step, compose an image from quantized subband
function qrecover_pic = subbandCompose(a_hat)
  
qrecover_LL1_lulu = iwsqTransform(a_hat{1}, a_hat{3},a_hat{2}, a_hat{4});
qrecover_LL1_lu = iwsqTransform(qrecover_LL1_lulu, a_hat{6},a_hat{5}, a_hat{7});
qrecover_LL1_lb = iwsqTransform(a_hat{12},a_hat{14},a_hat{13},a_hat{15});
qrecover_LL1_ru = iwsqTransform(a_hat{8},a_hat{10},a_hat{9},a_hat{11});
qrecover_LL1_rb = iwsqTransform(a_hat{16},a_hat{18},a_hat{17},a_hat{19});
qrecover_LL1 = iwsqTransform(qrecover_LL1_lu(1:67,1:87),qrecover_LL1_lb(1:67,1:87),qrecover_LL1_ru(1:67,1:87),qrecover_LL1_rb(1:67,1:87));

qrecover_LH1_lu = iwsqTransform(a_hat{20},a_hat{22},a_hat{21},a_hat{23});
qrecover_LH1_lb = iwsqTransform(a_hat{28},a_hat{30},a_hat{29},a_hat{31});
qrecover_LH1_ru = iwsqTransform(a_hat{24},a_hat{26},a_hat{25},a_hat{27});
qrecover_LH1_rb = iwsqTransform(a_hat{32},a_hat{34},a_hat{33},a_hat{35});
qrecover_LH1 = iwsqTransform(qrecover_LH1_lu(1:67,1:87),qrecover_LH1_lb(1:67,1:87),qrecover_LH1_ru(1:67,1:87),qrecover_LH1_rb(1:67,1:87));

qrecover_HL1_lu = iwsqTransform(a_hat{36},a_hat{38},a_hat{37},a_hat{39});
qrecover_HL1_lb = iwsqTransform(a_hat{44},a_hat{46},a_hat{45},a_hat{47});
qrecover_HL1_ru = iwsqTransform(a_hat{40},a_hat{42},a_hat{41},a_hat{43});
qrecover_HL1_rb = iwsqTransform(a_hat{48},a_hat{50},a_hat{49},a_hat{51});
qrecover_HL1 = iwsqTransform(qrecover_HL1_lu(1:67,1:87),qrecover_HL1_lb(1:67,1:87),qrecover_HL1_ru(1:67,1:87),qrecover_HL1_rb(1:67,1:87));

qrecover_LL = iwsqTransform(qrecover_LL1,qrecover_LH1,qrecover_HL1,a_hat{52});

qrecover_HL = iwsqTransform(a_hat{53},a_hat{55},a_hat{54},a_hat{56});
qrecover_LH = iwsqTransform(a_hat{57},a_hat{59},a_hat{58},a_hat{60});
qrecover_HH = iwsqTransform(a_hat{61},a_hat{63},a_hat{62},a_hat{64});

qrecover_pic = iwsqTransform(qrecover_LL,qrecover_LH,qrecover_HL,qrecover_HH);
imshow(qrecover_pic,[min(min(qrecover_pic)), max(max(qrecover_pic))])
  
end
