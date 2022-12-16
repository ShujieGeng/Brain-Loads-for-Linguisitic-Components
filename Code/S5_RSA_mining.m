clear
clc

load('RSA_CW.mat');% variable name:RSA_Chi_parsg_fm;

Nsub = 51;
%components:3 (Logo-grapheme,Phonology,Semantics)
Zval = zeros(Nsub,length(RSA_Chi_parsg_fm{1,1}),3);
for sub = 1:Nsub
    for com = 1:3
        temp = RSA_Chi_parsg_fm{sub,com};
        Zval(sub,:,com) = 0.5*(log((1+temp)./(1-temp)));       
    end
end
[~,p] = ttest(Zval,0,'Tail','Right');
Pval_fMRSK_Chi_parsg_fm = reshape(p,[length(RSA_Chi_parsg_fm{1,1}),3]);
save Pval_fMRSK_Chi_parsg_fm Pval_fMRSK_Chi_parsg_fm
%---------------------Mask ID-------------------
load('gfMask.mat');
rmask = load_untouch_nii('rMask_30ROIs.nii');
mask_ref = spm_select('List',pwd,'^rgrayTPM.*\.nii$');
mask_hdrs = spm_vol(mask_ref);
[maskdata,~] = spm_read_vols(mask_hdrs);
maskINDs = find((maskdata>0.2).*...
    (logical(rmask.img)~=0).*...
    (logical(gfMask)~=0));
%-------------------BrainLoad_CW gene---------------
MASK_Chi_05_parsg_fm = (Pval_fMRSK_Chi_parsg_fm<0.05);

MASK_word = zeros(length(MASK_word_05_parsg_fm),1);
MASK_word(MASK_word_05_parsg_fm(:,1)==1)=1;%Logo-grapheme values 1
MASK_word(MASK_word_05_parsg_fm(:,2)==1)=4;%Phonology values 1
MASK_word(MASK_word_05_parsg_fm(:,3)==1)=6;%Semantics values 1
MASK_word(logical((MASK_word_05_parsg_fm(:,1)==1).*(MASK_word_05_parsg_fm(:,2)==1)))=0;
MASK_word(logical((MASK_word_05_parsg_fm(:,1)==1).*(MASK_word_05_parsg_fm(:,3)==1)))=0;
MASK_word(logical((MASK_word_05_parsg_fm(:,2)==1).*(MASK_word_05_parsg_fm(:,3)==1)))=0;
MASK_word(logical((MASK_word_05_parsg_fm(:,1)==1).*(MASK_word_05_parsg_fm(:,2)==1).*(MASK_word_05_parsg_fm(:,3)==1)))=0;

data = load_untouch_nii('rgrayTPM_mask.nii');
[x,y,z] = ind2sub(size(data.img),maskINDs);
finalMask_word = zeros(size(data.img));
for i = 1:length(MASK_word)
    finalMask_word(x(i),y(i),z(i)) = MASK_word(i,1);
end
data.img = finalMask_word;
save_untouch_nii(data,'S5_2_BrainLoad_CW.nii');
%%
clc
%Chinse word
Zval_Chi_9_parsg_fm = zeros(51,30,9);
for sub = 1:51
    for roi = 1:30
        %logographeme
        word_logo = Zval(sub,:,1)';mask_inde = ((MASK_Chi_05_parsg_fm(:,1).*(aa==roi))==1);
        klogo = word_logo(mask_inde);klogo(isnan(klogo))=[];klogo(klogo<0)=[];
        if klogo~=0
            Zval_Chi_9_parsg_fm(sub,roi,1) = sum(klogo); %sum
            Zval_Chi_9_parsg_fm(sub,roi,2) = max(klogo); %peak
            Zval_Chi_9_parsg_fm(sub,roi,3) = length(klogo); %size
        end
        
        %phonology
        word_pho = Zval(sub,:,2)';mask_inde = ((MASK_Chi_05_parsg_fm(:,2).*(aa==roi))==1);
        kpho = word_pho(mask_inde);kpho(isnan(kpho))=[];kpho(kpho<0)=[];
        if kpho~=0
            Zval_Chi_9_parsg_fm(sub,roi,4) = sum(kpho); %sum
            Zval_Chi_9_parsg_fm(sub,roi,5) = max(kpho); %peak
            Zval_Chi_9_parsg_fm(sub,roi,6) = length(kpho); %size
        end
        
        %Semantic
        word_sem = Zval(sub,:,3)';mask_inde = ((MASK_Chi_05_parsg_fm(:,3).*(aa==roi))==1);
        ksem = word_sem(mask_inde);ksem(isnan(ksem))=[];ksem(ksem<0)=[];
        if ksem~=0
            Zval_Chi_9_parsg_fm(sub,roi,7) = sum(ksem); %sum
            Zval_Chi_9_parsg_fm(sub,roi,8) = max(ksem); %peak
            Zval_Chi_9_parsg_fm(sub,roi,9) = length(ksem); %size
        end
    end
end
save S5_3_rsaZ_CW Zval_Chi_9_parsg_fm