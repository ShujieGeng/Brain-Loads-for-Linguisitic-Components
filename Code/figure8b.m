%%
clear
clc

load('S5_3_rsaZ_CW.mat');%variable name: Zval_Chi_9_parsg_fm
load('S5_3_rsaZ_CP.mat');%variable name: Zval_pinyin_9_parsg_fm
load('S5_3_rsaZ_EW.mat');%variable name: Zval_Eng_9_parsg_fm
load('S1_3_aoa.mat');%variable name: aoa

Zval_Chi_9_parsg_groupSum = reshape(sum(Zval_Chi_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);
Zval_pinyin_9_parsg_groupSum = reshape(sum(Zval_pinyin_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);
Zval_Eng_9_parsg_groupSum = reshape(sum(Zval_Eng_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);

%----------------aoa < 9 ------------------------------------
subplot(211);
myc = [60 135 255;77 170 15;255 110 25.5]/255;

%figure8 right 7*12inches, 600dpi, 12 fontsize, 1.5pounds line
ykk = cat(2,Zval_Chi_9_parsg_groupSum(aoa<9,:),...
    Zval_Eng_9_parsg_groupSum(aoa<9,:),...
    Zval_pinyin_9_parsg_groupSum(aoa<9,:));
data1 = cell(1,3);%1*m cell, m boxes in each group
data1{1,1} = cat(2,ykk(:,1),ykk(:,4),ykk(:,7)); %n column, n group
data1{1,2} = cat(2,ykk(:,2),ykk(:,5),ykk(:,8));
data1{1,3} = cat(2,ykk(:,3),ykk(:,6),ykk(:,9));

subplot(211)
boxplotGroup(data1,'interGroupSpace',3,...
    'widths',.8,'colors',myc,'notch','on');
set(gca,'xtick',[2:6:14]);
set(gca,'xticklabel',{'Chinese word','English word','Chinese pinyin'});
set(gca,'ylim',[0,490]);
set(gca,'ytick',[0:100:490]);
box off;
hold on;
%Chinese
plot([1-0.05,2-0.05],[150,150],'k');%1vs2
text((1+2)/2,162,'NS','HorizontalAlignment','center','Fontsize',10);
plot([2+0.05,3+0.05,],[150,150],'k');%2vs3
text((2+3)/2,162,'NS','HorizontalAlignment','center','Fontsize',10);
plot([1-0.05,3+0.05,],[190,190],'k');%1vs3
text(2,202,'NS','HorizontalAlignment','center','Fontsize',10);
%English
plot([7-0.05,8-0.05],[440,440],'k');%1vs2
text((7+8)/2,448,'***','HorizontalAlignment','center');
plot([8+0.05,9+0.05,],[440,440],'k');%2vs3
text((8+9)/2,448,'***','HorizontalAlignment','center');
plot([7-0.05,9+0.05,],[470,470],'k');%1vs3
text(8,478,'***','HorizontalAlignment','center');
%Pinyin
plot([13-0.05,14-0.05],[370,370],'k');%1vs2
text((13+14)/2,378,'***','HorizontalAlignment','center');
plot([14+0.05,15+0.05,],[370,370],'k');%2vs3
text((14+15)/2,378,'***','HorizontalAlignment','center');
plot([13-0.05,15+0.05,],[400,400],'k');%1vs3
text(14,408,'***','HorizontalAlignment','center');
title('AOA range from 3-8 years');
ylabel('Cognitive Loads');
hold on;
%----------------aoa > 9 ------------------------------------
%figure8 7*8inches, 600dpi, 12 fontsize, 1.5pounds line
myc = [60 135 255;77 170 15;255 110 25.5]/255;
yk = cat(2,Zval_Chi_9_parsg_groupSum(aoa>8,:),...
    Zval_Eng_9_parsg_groupSum(aoa>8,:),...
    Zval_pinyin_9_parsg_groupSum(aoa>8,:));
data2 = cell(1,3);%1*m cell, m boxes in each group
data2{1,1} = cat(2,yk(:,1),yk(:,4),yk(:,7)); %n column, n group
data2{1,2} = cat(2,yk(:,2),yk(:,5),yk(:,8));
data2{1,3} = cat(2,yk(:,3),yk(:,6),yk(:,9));

subplot(212)
boxplotGroup(data2,'interGroupSpace',3,...
    'widths',.8,'colors',myc,'notch','on');
set(gca,'xtick',[2:6:14]);
set(gca,'xticklabel',{'Chinese word','English word','Chinese pinyin'});
set(gca,'ylim',[0,450]);
set(gca,'ytick',[0:100:450]);
box off;
hold on;
%Chinese
plot([1-0.05,2-0.05],[130,130],'k');%1vs2
text((1+2)/2,142,'NS','HorizontalAlignment','center','Fontsize',10);
plot([2+0.05,3+0.05,],[130,130],'k');%2vs3
text((2+3)/2,142,'NS','HorizontalAlignment','center','Fontsize',10);
plot([1-0.05,3+0.05,],[170,170],'k');%1vs3
text(2,182,'NS','HorizontalAlignment','center','Fontsize',10);
%English
plot([7-0.05,8-0.05],[390,390],'k');%1vs2
text((7+8)/2,398,'***','HorizontalAlignment','center');
plot([8+0.05,9+0.05,],[390,390],'k');%2vs3
text((8+9)/2,398,'***','HorizontalAlignment','center');
plot([7-0.05,9+0.05,],[420,420],'k');%1vs3
text(8,428,'***','HorizontalAlignment','center');
%Pinyin
plot([13-0.05,14-0.05],[280,280],'k');%1vs2
text((13+14)/2,288,'***','HorizontalAlignment','center');
plot([14+0.05,15+0.05,],[280,280],'k');%2vs3
text((14+15)/2,288,'***','HorizontalAlignment','center');
plot([13-0.05,15+0.05,],[310,310],'k');%1vs3
text(14,318,'***','HorizontalAlignment','center');
title('AOA range from 9-15 years');
ylabel('Cognitive Loads');
hold on;