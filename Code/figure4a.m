%%
%----------------Feature Extraction for SVR-------------------------------
clear
clc

load('S5_3_rsaZ_CW.mat');%variable name: Zval_Chi_9_parsg_fm
load('S5_3_rsaZ_CP.mat');%variable name: Zval_pinyin_9_parsg_fm
load('S5_3_rsaZ_EW.mat');%variable name: Zval_Eng_9_parsg_fm

Zval_Chi_9_parsg_fm_groupSum = reshape(sum(Zval_Chi_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);
Zval_pinyin_9_parsg_fm_groupSum = reshape(sum(Zval_pinyin_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);
Zval_Eng_9_parsg_fm_groupSum = reshape(sum(Zval_Eng_9_parsg_fm(:,:,[1,4,7]),2),[51,3]);

svr_feature2 = cat(1,cat(2,Zval_Chi_9_parsg_fm(:,:,1),Zval_Chi_9_parsg_fm(:,:,4),Zval_Chi_9_parsg_fm(:,:,7)),...
    cat(2,Zval_pinyin_9_parsg_fm(:,:,1),Zval_pinyin_9_parsg_fm(:,:,4),Zval_pinyin_9_parsg_fm(:,:,7)),...
    cat(2,Zval_Eng_9_parsg_fm(:,:,1),Zval_Eng_9_parsg_fm(:,:,4),Zval_Eng_9_parsg_fm(:,:,7)));
save svr_feature2 svr_feature2

svr_y = cat(1,ones(51,1),ones(51,1).*2,ones(51,1).*3);
save svr_y svr_y
%------SVR analysis was performed in Python----------
%----------------------------Visualization--------------------------------
%-----------------------------figure 4a-----------------------------------
clear
clc
myc = [155 126 184;174 192 50;219 112 147]/255;
% 
load('S7_1_y_pred.mat');%variable name: y_pred
y_pred = y_pred';
subplot(2,2,1);
boxplot(y_pred,'widths',0.6,'notch','on','colors',colormap(myc));box off;
ylabel('Predicted value','FontWeight','bold');
title('Total');
set(gca,'xticklabel',{'Chinese word','English word ','Chinese pinyin'});
set(gca,'xticklabelrotation',25);
set(gca,'ylim',[0.5,3.5]);set(gca,'ytick',[1:3]);
hold on;

load('S7_1_y_pred_logo.mat');%variable name: y_pred_logo
ypred = y_pred_logo';
subplot(2,2,2);
boxplot(ypred,'widths',0.6,'notch','on','colors',colormap(myc));box off;
title('Logo-grapheme');
set(gca,'xticklabel',{'Chinese word','English word ','Chinese pinyin'});
set(gca,'xticklabelrotation',25);
set(gca,'ylim',[0.5,3.5]);set(gca,'ytick',[1:3]);

load('S7_1_y_pred_pho.mat');%variable name: y_pred_pho
ypred = y_pred_pho';
subplot(2,2,3);
boxplot(ypred,'widths',0.6,'notch','on','colors',colormap(myc));box off;
ylabel('Predicted value','FontWeight','bold');
title('Phonology');
set(gca,'xticklabel',{'Chinese word','English word ','Chinese pinyin'});
set(gca,'xticklabelrotation',25);
set(gca,'ylim',[0.5,3.5]);set(gca,'ytick',[1:3]);

load('S7_1_y_pred_sem.mat');%variable name: y_pred_sem
ypred = y_pred_sem';
subplot(2,2,4);
boxplot(ypred,'widths',0.6,'notch','on','colors',colormap(myc));box off;
title('Semantics');
set(gca,'xticklabel',{'Chinese word','English word ','Chinese pinyin'});
set(gca,'xticklabelrotation',25);
set(gca,'ylim',[0.5,3.5]);set(gca,'ytick',[1:3]);
% 9*9 inches, 600dpi, 12 fontsize, 1.5 pounds line