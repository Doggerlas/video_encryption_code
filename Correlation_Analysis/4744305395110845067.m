%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% ����ͼ������ϵ��%% %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ���ߣ������� ʱ�䣺2008.6.9 %%
%%%%%%%% QQ��76424677   %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��������ͼ��
imgA=imread('nameA.jpg');
imgB=imread('nameB.jpg');

%����ת��
imgA=double(imgA);
imgB=double(imgB);

%��׳���ж�
[imgArow,imgAcol]=size(imgA);
[imgBrow,imgBcol]=size(imgB);
[imgArow,imgAcol]
[imgBrow,imgBcol]
if imgArow<1||imgAcol<1||imgBrow<1||imgBcol<1
    error('������������ά������С��1');
elseif imgArow~=imgBrow||imgAcol~=imgBcol
    error('������¾���ά������ȣ�');
end

%������ͼ��ľ�ֵ��
imgA=imgA-mean2(imgA);
imgB=imgB-mean2(imgB);

%��������ͼ������ϵ��
CC=sum(sum(imgA.*imgB))./(sqrt(sum(sum(imgA.^2))).*sqrt(sum(sum(imgB.^2))));

 