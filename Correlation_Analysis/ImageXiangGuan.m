clear all;
clc;
figure(1)
I=imread('D:\OneDrive\����\h.264���ݷ�������\��Ե����Է���\Football\d_football.bmp');
c=double(rgb2gray(I));%�������ת��Ϊdouble��
subplot(2,1,1)
imshow(c,[]);%��Ϊ�Ҷ�ֵ��ʹ��imshow(c)���ɣ���c��Ϊdouble�ͣ�����ʾ�������������Ϊimshow(c,[]),����鿴help imshow��

B=imread('D:\OneDrive\����\h.264���ݷ�������\��Ե����Է���\Football\e_Football.bmp');
E=double(rgb2gray(B));%�������ת��Ϊdouble��
subplot(2,1,2)
imshow(E,[]);

xlabel('(a)Barbara����ͼ��');
set(get(gca,'XLabel'),'Fontsize',15) %����Ա�ע�Ķ���������̶�
[x1,y1]=size(c);
PixelNum=x1*y1;%������ֵ
Cows=100; %ѡȡ���С��С��Խ���������ò�Ҫ����ͼƬ�ߵ�һ��,���(y1-x1+1)���ɣ�E�����Ϊ561
%%��ʼ����ѡȡ%%%
%�ֱ�Ϊ2��4��8��16  ����ʼ�е�ѡȡ����Ӱ���� ��ʼ��ǰ����ֱ����Ч���ã�Խ���м䣬�ԽǷ����
horInitSeq=4;
verInitSeq=4;
diaInitSeq=4;
% A:2��8��8     B:4��8��2     C:2��8��4    D:2��8��4   E:2��8��2    F��4��4��4
%%%Cab-ԭͼ������ͼ�������ϵ��%%%
cSum=sum(c(:));%����������Ԫ�����
eSum=sum(E(:));%����������Ԫ�����
cMean=cSum/PixelNum;%Ҳ�ɸ�Ϊmean(c(:)),���һ������ռ��
eMean=eSum/PixelNum;%����ռ��
fenZi=0;fenMuLeft=0;fenMuRight=0;
for i=1:x1
  for j=1:y1
      cdiff=c(i,j)-cMean;%������-��������
      ediff=E(i,j)-eMean;
      fenZi=fenZi+cdiff*ediff;
      cdiffSquare=cdiff^2;
      ediffSquare=ediff^2;
      fenMuLeft=fenMuLeft+cdiffSquare;
      fenMuRight=fenMuRight+ediffSquare;
  end
end
allCorrCoe=fenZi/sqrt(fenMuLeft*fenMuRight)%%����


%%%%%%%%%%%ˮƽˮƽˮƽ%%%%%%%%%%%%
%%%Cab-ԭͼ������ͼ��ˮƽ���ϵ��%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cHorMean=mean(c,2);%����ÿ�е�ƽ��ֵ
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
for i=horInit:horLast  %ע�� i,jС��ͼ��ߴ�
  for j=1:x1              %����ͳһ��������������� ��j�ķ�Χy1��Ϊx1
      cdiff=c(i,j)-cHorChoiceMean;
      ediff=E(i,j)-eHorChoiceMean;
      horFenZi=horFenZi+cdiff*ediff;
      cdiffSquare=cdiff^2;
      ediffSquare=ediff^2;
      horFenMuLeft=horFenMuLeft+cdiffSquare;
      horFenMuRight=horFenMuRight+ediffSquare;
  end
end
horCorrCoe=horFenZi/sqrt(horFenMuLeft*horFenMuRight)%%ˮƽ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ˮƽ������ͼ
 i=horInit:horLast; %����ͳһ��������������� ��j�ķ�Χy1��Ϊx1
 j=1:x1;
 figure(2);
 %subplot(4,1,1);
 plot(c(i,j),E(i,j),'m.','Markersize',1);
 title('(a) ���������ϵ��(ˮƽ����)');
 xlabel('����(x,y)��������ֵ');
 ylabel('����(x,y)��������ֵ');
 axis([0 255 0 255]);
 set(gca,'FontSize',12);%ֻ��ͬʱ�ı�x y����ʾ�������С��

 
%%%%%%%%%%%��ֱ��ֱ��ֱ%%%%%%%%%%%%
%%%Cab-ԭͼ������ͼ�Ĵ�ֱ���ϵ��%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cVerMean=mean(c,1);%����ÿ��ƽ��ֵ
eVerMean=mean(E,1);
cVerChoiceSum=0;%ѡ����Ӧ�еľ�ֵ�ĺ�
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
for j=verInit:verLast %������ӦԪ��
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
verCorrCoe=verFenZi/sqrt(verFenMuLeft*verFenMuRight)%%��ֱ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ֱ������ͼ
j=verInit:verLast;%������ӦԪ��
i=1:x1;
 figure(3);
 %subplot(4,1,1);
 plot(c(i,j),E(i,j),'m.','Markersize',1);
 title('(b�����������ϵ��(��ֱ����)');
 xlabel('����(x,y)��������ֵ');
 ylabel('����(x,y)��������ֵ');
 axis([0 255 0 255]);
 set(gca,'FontSize',12);%ֻ��ͬʱ�ı�x y����ʾ�������С��


%%%%%%%%%%%%%%%%%%%%�ԽǶԽǶԽ�%%%%%%%%%%%%%%%%%%%%%%
%%%Cab-ԭͼ������ͼ�ĶԽ����ϵ��%%%--��ֹ����ά�Ȳ�ƥ�䣬
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cDiaChoiceSum=0;
eDiaChoiceSum=0;
diaInit=(y1-x1)/diaInitSeq;
diaLast=(y1-x1)/diaInitSeq+Cows-1;
for i=diaInit:diaLast
    cDiaChoiceSum=cDiaChoiceSum+mean(diag(c,i),1);%diag���Ϊ������
    eDiaChoiceSum=eDiaChoiceSum+mean(diag(E,i),1);
end
cDiaChoiceMean=cDiaChoiceSum/Cows;
eDiaChoiceMean=eDiaChoiceSum/Cows;
diaFenZi=0;diaFenMuLeft=0;diaFenMuRight=0;
for i=1:x1%���Խ��߿���б�м���
  for j=diaInit:diaLast  %ע�� i,i+jС��ͼ��ߴ� �Խǳ�ʼ����ѡȡ
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�ԽǷ�����ͼ
for i=diaInit:diaLast
    cDia(:,i-diaInit+1)=diag(c,i);%diag���Ϊ������
    eDia(:,i-diaInit+1)=diag(E,i);
end
 i=1:x1;%���Խ��߿���б�м���
 j=1:Cows;
 figure(4);
 plot(cDia(i,j),eDia(i,j),'m.','Markersize',1);
 title('(c�����������ϵ��(�ԽǷ���)');
 xlabel('����(x,y)��������ֵ');
 ylabel('����(x,y)��������ֵ');
 axis([0 255 0 255]);
 set(gca,'FontSize',12);%ֻ��ͬʱ�ı�x y����ʾ�������С��
