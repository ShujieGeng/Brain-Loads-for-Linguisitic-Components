%%
clear
clc

load('S5_3_rsaZ_CW.mat');%variable name: Zval_Chi_9_parsg_fm
load('S5_3_rsaZ_CP.mat');%variable name: Zval_pinyin_9_parsg_fm
load('S5_3_rsaZ_EW.mat');%variable name: Zval_Eng_9_parsg_fm

Zval_Chi_9_parsg_groupSum = reshape(sum(Zval_Chi_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);
Zval_pinyin_9_parsg_groupSum = reshape(sum(Zval_pinyin_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);
Zval_Eng_9_parsg_groupSum = reshape(sum(Zval_Eng_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);

Zval_logo_9_parsg_groupSum = cat(2,Zval_Chi_9_parsg_groupSum(:,1),...
                                    Zval_Eng_9_parsg_groupSum(:,1),...
                                    Zval_pinyin_9_parsg_groupSum(:,1));
Zval_pho_9_parsg_groupSum = cat(2,Zval_Chi_9_parsg_groupSum(:,2),...
                                    Zval_Eng_9_parsg_groupSum(:,2),...
                                    Zval_pinyin_9_parsg_groupSum(:,2));
Zval_sem_9_parsg_groupSum = cat(2,Zval_Chi_9_parsg_groupSum(:,3),...
                                    Zval_Eng_9_parsg_groupSum(:,3),...
                                    Zval_pinyin_9_parsg_groupSum(:,3));
                                
ykk = cat(2,Zval_logo_9_parsg_groupSum,...
    Zval_pho_9_parsg_groupSum,...
    Zval_sem_9_parsg_groupSum);
myc = [155 126 184;174 192 50;219 112 147]/255;
data1 = cell(1,3);%1*m cell, m boxes in each group
data1{1,1} = cat(2,ykk(:,1),ykk(:,4),ykk(:,7)); %n column, n group
data1{1,2} = cat(2,ykk(:,2),ykk(:,5),ykk(:,8));
data1{1,3} = cat(2,ykk(:,3),ykk(:,6),ykk(:,9));

%figure3b 7*6inches, 600dpi, 12 fontsize, 1.5pounds line
boxplotGroup(data1,'interGroupSpace',3,...
    'widths',.8,'colors',myc,'notch','on');
set(gca,'xtick',[2:6:14]);
set(gca,'xticklabel',{'Logo-grapheme','Phonology','Semantics'});
set(gca,'ylim',[0,490]);
set(gca,'ytick',[0:100:490]);
box off;
hold on;
%Chinese
plot([1-0.05,2-0.05],[210,210],'k');%1vs2
text((1+2)/2,222,'***','HorizontalAlignment','center','Fontsize',10);
plot([2+0.05,3+0.05,],[210,210],'k');%2vs3
text((2+3)/2,222,'NS','HorizontalAlignment','center','Fontsize',10);
plot([1-0.05,3+0.05,],[250,250],'k');%1vs3
text(2,262,'***','HorizontalAlignment','center','Fontsize',10);
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
ylabel('Cognitive Loads');
hold on;

