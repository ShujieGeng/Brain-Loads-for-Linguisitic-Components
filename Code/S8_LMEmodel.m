%%
clear
clc

load('S5_3_rsaZ_CW.mat');% variable name:Zval_Chi_9_parsg_fm
load('Pval_fMRSK_Chi_parsg_fm.mat');
load('S1_1_ACC.mat');%variable name:meanRT_exp3

%---------------------Mask ID-------------------
load('gfMask.mat');
rmask = load_untouch_nii('rMask_30ROIs.nii');
mask_ref = spm_select('List',pwd,'^rgrayTPM.*\.nii$');
mask_hdrs = spm_vol(mask_ref);
[maskdata,~] = spm_read_vols(mask_hdrs);
maskINDs = find((maskdata>0.2).*...
    (logical(rmask.img)~=0).*...
    (logical(gfMask)~=0));
%------------------fitted reaction time----------------
Rv_logo = cat(1,sum(Zval_Chi_9_parsg_fm(1:44,:,1),2),...
    sum(Zval_pinyin_9_parsg_fm(1:44,:,1),2),...
    sum(Zval_Eng_9_parsg_fm(1:44,:,1),2));

S = [1:44 1:44 1:44 ]';
RT = cat(1,meanRT_exp3(1:44,1),meanRT_exp3(1:44,2),meanRT_exp3(1:44,3));
factName={'Rv_logo','Rv_pho','Rv_sem','Subj','RT'};
LLT = table(Rv_logo,Rv_pho,Rv_sem,S,RT,'VariableNames',factName);

figure;

lmelogo = fitlme(LLT,'RT ~ Rv_logo + (1 | Subj)');
yhat_logo = predict(lmelogo);
save yhat_logo yhat_logo
%%--------------Scatter LME fitted RT-------------
% plot(RT,yhat_logo,'ro');hold on;
% [bl,bint,rl,rint] = regress(RT,yhat_logo);
% x = 300:2500;y = bl*x + mean(rl);
% plot(x,y,'r','Linestyle','--');hold on;
% xlabel('Reaction Time');
% ylabel('Fitted RT');
% title('Logo-Representation');
% [r1,p1] = corr(yhat_logo,Rv_logo);%logo
%-------------------------------------------------