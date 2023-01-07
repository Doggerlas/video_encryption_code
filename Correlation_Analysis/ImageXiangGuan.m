clear all;
clc;
figure(1)
I=imread('D:\OneDrive\桌面\h.264数据分析处理\边缘检测性分析\Football\d_football.bmp');
c=double(rgb2gray(I));%务毕类型转换为double型
subplot(2,1,1)
imshow(c,[]);%若为灰度值，使用imshow(c)即可，但c变为double型，则显示不出来，必须改为imshow(c,[]),具体查看help imshow。

B=imread('D:\OneDrive\桌面\h.264数据分析处理\边缘检测性分析\Football\e_Football.bmp');
E=double(rgb2gray(B));%务毕类型转换为double型
subplot(2,1,2)
imshow(E,[]);

xlabel('(a)Barbara明文图像');
set(get(gca,'XLabel'),'Fontsize',15) %是针对标注的而不是坐标刻度
[x1,y1]=size(c);
PixelNum=x1*y1;%总像素值
Cows=100; %选取的行、列、对角线数，最好不要超过图片高的一半,最多(y1-x1+1)即可，E类最多为561
%%初始序列选取%%%
%分别为2、4、8、16  且起始列的选取严重影响结果 起始靠前，垂直方向效果好，越靠中间，对角方向好
horInitSeq=4;
verInitSeq=4;
diaInitSeq=4;
% A:2、8、8     B:4、8、2     C:2、8、4    D:2、8、4   E:2、8、2    F：4、4、4
%%%Cab-原图与密文图的总相关系数%%%
cSum=sum(c(:));%对明文所有元素求和
eSum=sum(E(:));%对密文所有元素求和
cMean=cSum/PixelNum;%也可改为mean(c(:)),结果一样明文占比
eMean=eSum/PixelNum;%密文占比
fenZi=0;fenMuLeft=0;fenMuRight=0;
for i=1:x1
  for j=1:y1
      cdiff=c(i,j)-cMean;%总像素-明文像素
      ediff=E(i,j)-eMean;
      fenZi=fenZi+cdiff*ediff;
      cdiffSquare=cdiff^2;
      ediffSquare=ediff^2;
      fenMuLeft=fenMuLeft+cdiffSquare;
      fenMuRight=fenMuRight+ediffSquare;
  end
end
allCorrCoe=fenZi/sqrt(fenMuLeft*fenMuRight)%%整体


%%%%%%%%%%%水平水平水平%%%%%%%%%%%%
%%%Cab-原图与密文图的水平相关系数%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cHorMean=mean(c,2);%返回每行的平均值
eHorMean=mean(E,2);
cHorChoiceSum=0;
eHorChoiceSum=0;
horInit=x1/horInitSeq;
horLast=x1/horInitSeq+Cows-1;
for i=horInit:horLast 
    cHorChoiceSum=cHorChoiceSum+cHorMean(i,1);
    eHorChoiceSum=eHorChoiceSum+eHorMean(i,1);
end
cHorChoiceMean=cHorChoiceSum/Cows;
eHorChoiceMean=eHorChoiceSum/Cows;
 horFenZi=0;horFenMuLeft=0;horFenMuRight=0;
for i=horInit:horLast  %注意 i,j小于图像尺寸
  for j=1:x1              %若需统一三个方向的像素数 则j的范围y1改为x1
      cdiff=c(i,j)-cHorChoiceMean;
      ediff=E(i,j)-eHorChoiceMean;
      horFenZi=horFenZi+cdiff*ediff;
      cdiffSquare=cdiff^2;
      ediffSquare=ediff^2;
      horFenMuLeft=horFenMuLeft+cdiffSquare;
      horFenMuRight=horFenMuRight+ediffSquare;
  end
end
horCorrCoe=horFenZi/sqrt(horFenMuLeft*horFenMuRight)%%水平
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%水平方向作图
 i=horInit:horLast; %若需统一三个方向的像素数 则j的范围y1改为x1
 j=1:x1;
 figure(2);
 %subplot(4,1,1);
 plot(c(i,j),E(i,j),'m.','Markersize',1);
 title('(a) 明密文相关系数(水平方向)');
 xlabel('明文(x,y)处的像素值');
 ylabel('密文(x,y)处的像素值');
 axis([0 255 0 255]);
 set(gca,'FontSize',12);%只能同时改变x y轴显示的字体大小；

 
%%%%%%%%%%%垂直垂直垂直%%%%%%%%%%%%
%%%Cab-原图与密文图的垂直相关系数%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cVerMean=mean(c,1);%返回每列平均值
eVerMean=mean(E,1);
cVerChoiceSum=0;%选中相应列的均值的和
eVerChoiceSum=0;
verInit=y1/verInitSeq;
verLast=y1/verInitSeq+Cows-1;
for i=verInit:verLast
    cVerChoiceSum=cVerChoiceSum+cVerMean(1,i);
    eVerChoiceSum=eVerChoiceSum+eVerMean(1,i);
end
cVerChoiceMean=cVerChoiceSum/Cows;
eVerChoiceMean=eVerChoiceSum/Cows;
verFenZi=0;verFenMuLeft=0;verFenMuRight=0;
for j=verInit:verLast %调用相应元素
  for  i=1:x1
      cdiff=c(i,j)-cVerChoiceMean;
      ediff=E(i,j)-eVerChoiceMean;
      verFenZi=verFenZi+cdiff*ediff;
      cdiffSquare=cdiff^2;
      ediffSquare=ediff^2;
      verFenMuLeft=verFenMuLeft+cdiffSquare;
      verFenMuRight=verFenMuRight+ediffSquare;
  end
end
verCorrCoe=verFenZi/sqrt(verFenMuLeft*verFenMuRight)%%垂直
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%垂直方向作图
j=verInit:verLast;%调用相应元素
i=1:x1;
 figure(3);
 %subplot(4,1,1);
 plot(c(i,j),E(i,j),'m.','Markersize',1);
 title('(b）明密文相关系数(垂直方向)');
 xlabel('明文(x,y)处的像素值');
 ylabel('密文(x,y)处的像素值');
 axis([0 255 0 255]);
 set(gca,'FontSize',12);%只能同时改变x y轴显示的字体大小；


%%%%%%%%%%%%%%%%%%%%对角对角对角%%%%%%%%%%%%%%%%%%%%%%
%%%Cab-原图与密文图的对角相关系数%%%--防止数组维度不匹配，
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cDiaChoiceSum=0;
eDiaChoiceSum=0;
diaInit=(y1-x1)/diaInitSeq;
diaLast=(y1-x1)/diaInitSeq+Cows-1;
for i=diaInit:diaLast
    cDiaChoiceSum=cDiaChoiceSum+mean(diag(c,i),1);%diag结果为列向量
    eDiaChoiceSum=eDiaChoiceSum+mean(diag(E,i),1);
end
cDiaChoiceMean=cDiaChoiceSum/Cows;
eDiaChoiceMean=eDiaChoiceSum/Cows;
diaFenZi=0;diaFenMuLeft=0;diaFenMuRight=0;
for i=1:x1%将对角线看做斜列即可
  for j=diaInit:diaLast  %注意 i,i+j小于图像尺寸 对角初始序列选取
      cdiff=c(i,i+j)-cDiaChoiceMean;
      ediff=E(i,i+j)-eDiaChoiceMean;
      diaFenZi=diaFenZi+cdiff*ediff;
      cdiffSquare=cdiff^2;
      ediffSquare=ediff^2;
      diaFenMuLeft=diaFenMuLeft+cdiffSquare;
      diaFenMuRight=diaFenMuRight+ediffSquare;
  end
end
diaCorrCoe=diaFenZi/sqrt(diaFenMuLeft*diaFenMuRight)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%对角方向作图
for i=diaInit:diaLast
    cDia(:,i-diaInit+1)=diag(c,i);%diag结果为列向量
    eDia(:,i-diaInit+1)=diag(E,i);
end
 i=1:x1;%将对角线看做斜列即可
 j=1:Cows;
 figure(4);
 plot(cDia(i,j),eDia(i,j),'m.','Markersize',1);
 title('(c）明密文相关系数(对角方向)');
 xlabel('明文(x,y)处的像素值');
 ylabel('密文(x,y)处的像素值');
 axis([0 255 0 255]);
 set(gca,'FontSize',12);%只能同时改变x y轴显示的字体大小；
