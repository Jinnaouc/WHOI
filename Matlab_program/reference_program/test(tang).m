clc
clear
f=imread('test.bmp');
imshow(f);
[M N]=size(f);
F=fft2(f);%没有经过0扩充直接计算fft
sig=10;%高斯滤波参数˝
H=lpfilter('gaussian',M,N,sig);
G=H.*F;%加了.号的乘法表示对应每个元素都相乘，没加.号的乘法说明是真正的矩阵乘法。
g=real(ifft2(G));
figure,imshow(g,[]);
