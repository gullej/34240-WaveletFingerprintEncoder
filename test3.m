% Test of WSQ
close all; clearvars; clc;

files = dir('DB1_B/*.tif');
values = [];
names = [];
bpp = 4;

for file = files'
    file.name
    img = imread(strcat('DB1_B/',file.name));
    [psnr, mse, per, rate] = evaluateCompression(img, bpp);
    names = [names; file.name];
    values = [values ; psnr, mse, per, rate];
end
