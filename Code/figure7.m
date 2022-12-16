clear
clc
%------------------------Calculate Partialcorr efficients----------------------
load('S5_3_rsaZ_CW.mat');%variable name: Zval_Chi_9_parsg_fm
load('S5_3_rsaZ_CP.mat');%variable name: Zval_pinyin_9_parsg_fm
load('S5_3_rsaZ_EW.mat');%variable name: Zval_Eng_9_parsg_fm
load('Pval_fMRSK_Chi_parsg_fm.mat');
load('Pval_fMRSK_pinyin_parsg_fm.mat');
load('Pval_fMRSK_Eng_parsg_fm.mat');
load('S1_2_RT.mat');%variable name: meanRT_exp3
load('yhat_logo.mat');load('yhat_pho.mat');load('yhat_sem.mat');

[r1,p1] = partialcorr(sum(Zval_Chi_9_parsg_fm(1:44,:,1),2),yhat_logo(1:44,1),...
    cat(2,sum(Zval_Chi_9_parsg_fm(1:44,:,7),2),sum(Zval_Chi_9_parsg_fm(1:44,:,4),2)));
[r2,p2] = partialcorr(sum(Zval_Chi_9_parsg_fm(1:44,:,4),2),yhat_pho(1:44,1),...
    cat(2,sum(Zval_Chi_9_parsg_fm(1:44,:,7),2),sum(Zval_Chi_9_parsg_fm(1:44,:,1),2)));
[r3,p3] = partialcorr(sum(Zval_Chi_9_parsg_fm(1:44,:,7),2),yhat_sem(1:44,1),...
    cat(2,sum(Zval_Chi_9_parsg_fm(1:44,:,4),2),sum(Zval_Chi_9_parsg_fm(1:44,:,1),2)));
total_chi = sum(Zval_Chi_9_parsg_fm(1:44,:,1),2) + ...
    sum(Zval_Chi_9_parsg_fm(1:44,:,7),2) + ...
    sum(Zval_Chi_9_parsg_fm(1:44,:,4),2);
[r11,p11] = corr(total_chi,meanRT_exp3(1:44,1));

[r4,p4] = partialcorr(sum(Zval_Eng_9_parsg_fm(1:44,:,1),2),yhat_logo(89:132,1),...
    cat(2,sum(Zval_Eng_9_parsg_fm(1:44,:,7),2),sum(Zval_Eng_9_parsg_fm(1:44,:,4),2)));
[r5,p5] = partialcorr(sum(Zval_Eng_9_parsg_fm(1:44,:,4),2),yhat_pho(89:132,1),...
    cat(2,sum(Zval_Eng_9_parsg_fm(1:44,:,7),2),sum(Zval_Eng_9_parsg_fm(1:44,:,1),2)));
[r6,p6] = partialcorr(sum(Zval_Eng_9_parsg_fm(1:44,:,7),2),yhat_sem(89:132,1),...
    cat(2,sum(Zval_Eng_9_parsg_fm(1:44,:,4),2),sum(Zval_Eng_9_parsg_fm(1:44,:,1),2)));
total_Eng = sum(Zval_Eng_9_parsg_fm(1:44,:,1),2) + ...
    sum(Zval_Eng_9_parsg_fm(1:44,:,7),2) + ...
    sum(Zval_Eng_9_parsg_fm(1:44,:,4),2);
[r22,p22] = corr(total_Eng,meanRT_exp3(1:44,3));

[r7,p7] = partialcorr(sum(Zval_pinyin_9_parsg_fm(1:44,:,1),2),yhat_logo(45:88,1),...
    cat(2,sum(Zval_pinyin_9_parsg_fm(1:44,:,7),2),sum(Zval_pinyin_9_parsg_fm(1:44,:,4),2)));
[r8,p8] = partialcorr(sum(Zval_pinyin_9_parsg_fm(1:44,:,4),2),yhat_pho(45:88,1),...
    cat(2,sum(Zval_pinyin_9_parsg_fm(1:44,:,7),2),sum(Zval_pinyin_9_parsg_fm(1:44,:,1),2)));
[r9,p9] = partialcorr(sum(Zval_pinyin_9_parsg_fm(1:44,:,7),2),yhat_sem(45:88,1),...
    cat(2,sum(Zval_pinyin_9_parsg_fm(1:44,:,4),2),sum(Zval_pinyin_9_parsg_fm(1:44,:,1),2)));
total_pin = sum(Zval_pinyin_9_parsg_fm(1:44,:,1),2) + ...
    sum(Zval_pinyin_9_parsg_fm(1:44,:,7),2) + ...
    sum(Zval_pinyin_9_parsg_fm(1:44,:,4),2);
[r33,p33] = corr(total_pin,meanRT_exp3(1:44,2));
%%
%--------------------------Visualization--------------------------

myc = [60 135 255;77 170 15;255 110 25.5]/255;
myct = [238 13 137]/255;
%--------------------------Chinese word----------------------------
Rv_Chi = cat(2,sum(Zval_Chi_9_parsg_fm(1:44,:,1),2),...
    sum(Zval_Chi_9_parsg_fm(1:44,:,4),2),...
    sum(Zval_Chi_9_parsg_fm(1:44,:,7),2));
total_chi = sum(Zval_Chi_9_parsg_fm(1:44,:,1),2) + ...
    sum(Zval_Chi_9_parsg_fm(1:44,:,7),2) + ...
    sum(Zval_Chi_9_parsg_fm(1:44,:,4),2);

yk = (meanRT_exp3(1:44,1)-mean(meanRT_exp3(1:44,1)))./std(meanRT_exp3(1:44,1));
xk = cat(2,ones(44,1),(Rv_Chi-mean(Rv_Chi))./std(Rv_Chi));
[bl,~,rc,~,~] = regress(yk,xk);

%Chinese Word 
subplot(3,4,1);
scatter(xk(:,2),bl(2)*xk(:,2)+rc,[],myc(1,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2.5,3.5]);
ylabel('Adjusted Reaction Time','FontWeight','bold','Fontsize',14);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
title('Logo-grapheme');
x = -2.5:4;y = bl(2)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,3,'r = 0.454 *','HorizontalAlignment','center');

subplot(3,4,2);
scatter(xk(:,3),bl(3)*xk(:,3)+rc,[],myc(2,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
title('Phonology');
x = -2.5:2.8;y = bl(3)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,2.5,'r = -0.05 NS','HorizontalAlignment','center');

subplot(3,4,3);
scatter(xk(:,4),bl(4)*xk(:,4)+rc,[],myc(3,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
title('Semantics');
x = -2.5:3; y = bl(4)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.2,2.5,'r = 0.123 NS','HorizontalAlignment','center');

xkk = cat(2,ones(44,1),(total_chi-mean(total_chi))/std(total_chi));
[btc,~,rtc,~,~] = regress(yk,xkk);
subplot(3,4,4);
scatter(xkk(:,2),btc(2)*xkk(:,2)+rtc,[],myct,'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3.2]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
% title('Total-Representation');
title('Total');
x = -2.5:3; y = btc(2)*x + mean(rtc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,2.7,'r = 0.084 NS','HorizontalAlignment','center');
%--------------------------English word----------------------------
Rv_Eng = cat(2,sum(Zval_Eng_9_parsg_fm(1:44,:,1),2),...
    sum(Zval_Eng_9_parsg_fm(1:44,:,4),2),...
    sum(Zval_Eng_9_parsg_fm(1:44,:,7),2));
total_Eng = sum(Zval_Eng_9_parsg_fm(1:44,:,1),2) + ...
    sum(Zval_Eng_9_parsg_fm(1:44,:,7),2) + ...
    sum(Zval_Eng_9_parsg_fm(1:44,:,4),2);

yk = (meanRT_exp3(1:44,3)-mean(meanRT_exp3(1:44,3)))/std(meanRT_exp3(1:44,3));
xk = cat(2,ones(44,1),(Rv_Eng-mean(Rv_Eng))./std(Rv_Eng));
[bl,~,rc,~,~] = regress(yk,xk);

subplot(3,4,5);
scatter(xk(:,2),bl(2)*xk(:,2)+rc,[],myc(1,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2.5,3.5]);
ylabel('Adjusted Reaction Time','FontWeight','bold','Fontsize',14);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:4;y = bl(2)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,3,'r = 0.198 NS','HorizontalAlignment','center');

subplot(3,4,6);
scatter(xk(:,3),bl(3)*xk(:,3)+rc,[],myc(2,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:2.8;y = bl(3)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,2.5,'r = -0.309 marginal*','HorizontalAlignment','center');

subplot(3,4,7);
scatter(xk(:,4),bl(4)*xk(:,4)+rc,[],myc(3,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3]);
% title('Sem-Representation');
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:3; y = bl(4)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.2,2.5,'r = 0.257 NS','HorizontalAlignment','center');

xkk = cat(2,ones(44,1),(total_Eng-mean(total_Eng))/std(total_Eng));
[btc,~,rtc,~,~] = regress(yk,xkk);
subplot(3,4,8);
scatter(xkk(:,2),btc(2)*xkk(:,2)+rtc,[],myct,'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3.2]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:3; y = btc(2)*x + mean(rtc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,2.7,'r = -0.093 NS','HorizontalAlignment','center');

%--------------------------Chinese pinyin----------------------------
Rv_pinyin = cat(2,sum(Zval_pinyin_9_parsg_fm(1:44,:,1),2),...
    sum(Zval_pinyin_9_parsg_fm(1:44,:,4),2),...
    sum(Zval_pinyin_9_parsg_fm(1:44,:,7),2));
total_pinyin = sum(Zval_pinyin_9_parsg_fm(1:44,:,1),2) + ...
    sum(Zval_pinyin_9_parsg_fm(1:44,:,7),2) + ...
    sum(Zval_pinyin_9_parsg_fm(1:44,:,4),2);

yk = (meanRT_exp3(1:44,2)-mean(meanRT_exp3(1:44,2)))/std(meanRT_exp3(1:44,2));
xk = cat(2,ones(44,1),(Rv_pinyin-mean(Rv_pinyin))./std(Rv_pinyin));
[bl,bint,rc,rint,stats] = regress(yk,xk);

subplot(3,4,9);
scatter(xk(:,2),bl(2)*xk(:,2)+rc,[],myc(1,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2.5,3.5]);
ylabel('Adjusted Reaction Time','FontWeight','bold','Fontsize',14);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:4;y = bl(2)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,3,'r = 0.303 marginal*','HorizontalAlignment','center');

subplot(3,4,10);
scatter(xk(:,3),bl(3)*xk(:,3)+rc,[],myc(2,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:2.8;y = bl(3)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,2.5,'r = -0.029 NS','HorizontalAlignment','center');

subplot(3,4,11);
scatter(xk(:,4),bl(4)*xk(:,4)+rc,[],myc(3,:),'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:3; y = bl(4)*x + mean(rc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.2,2.5,'r = 0.528 **','HorizontalAlignment','center');

xkk = cat(2,ones(44,1),(total_pinyin-mean(total_pinyin))/std(total_pinyin));
[btc,binttc,rtc,rinttc,statstc] = regress(yk,xkk);
subplot(3,4,12);
scatter(xkk(:,2),btc(2)*xkk(:,2)+rtc,[],myct,'o','filled');hold on;
set(gca,'xlim',[-2.5,3]);set(gca,'ylim',[-2,3.2]);
xlabel('Adjusted Cognitive Loads','FontWeight','bold','Fontsize',14);
x = -2.5:3; y = btc(2)*x + mean(rtc);
plot(x,y,'k','Linestyle','--');hold on;
text(2.5,2.7,'r = 0.175 NS','HorizontalAlignment','center');

%15*10 inches; fontsize 12; dpi 600; line 1.2pound