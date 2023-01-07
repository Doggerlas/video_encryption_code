%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% 计算图像的相关系数%% %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 作者：刘建华 时间：2008.6.9 %%
%%%%%%%% QQ：76424677   %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%读入两幅图像
imgA=imread('nameA.jpg');
imgB=imread('nameB.jpg');

%精度转换
imgA=double(imgA);
imgB=double(imgB);

%健壮性判断
[imgArow,imgAcol]=size(imgA);
[imgBrow,imgBcol]=size(imgB);
[imgArow,imgAcol]
[imgBrow,imgBcol]
if imgArow<1||imgAcol<1||imgBrow<1||imgBcol<1
    error('您的输入有误！维数不能小于1');
elseif imgArow~=imgBrow||imgAcol~=imgBcol
    error('您输入德矩阵维数不相等！');
end

%求两幅图像的均值差
imgA=imgA-mean2(imgA);
imgB=imgB-mean2(imgB);

%求求两幅图像的相关系数
CC=sum(sum(imgA.*imgB))./(sqrt(sum(sum(imgA.^2))).*sqrt(sum(sum(imgB.^2))));

 