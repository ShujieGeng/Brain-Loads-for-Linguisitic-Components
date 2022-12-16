%pinyin
clear
clc

load('RSA_CP.mat');% variable name:RSA_pinyin_parsg_fm;

Zval = zeros(size(RSA_pinyin_parsg_fm,1),length(RSA_pinyin_parsg_fm{1,1}),3);
for sub = 1:size(RSA_pinyin_parsg_fm,1)
    for com = 1:3
        temp = RSA_pinyin_parsg_fm{sub,com};
        Zval(sub,:,com) = 0.5*(log((1+temp)./(1-temp)));       
    end
end

[~,p_51,~,stat_51] = ttest(Zval,0,'Tail','Right');
t_51 = reshape(stat_51.tstat,[size(stat_51.tstat,2),size(stat_51.tstat,3)]);

pinyin_perm = zeros(1000,6,21);
for perm = 1:1000
    
    for nsub = 1:21
    
        cc = randperm(51,30+nsub);
        RSA_pinyin_parsg_fm_perm = RSA_pinyin_parsg_fm(cc,:);
        
        Zval_perm = zeros(size(RSA_pinyin_parsg_fm_perm,1),length(RSA_pinyin_parsg_fm_perm{1,1}),3);
        for sub = 1:size(RSA_pinyin_parsg_fm_perm,1)
            for com = 1:3
                temp = RSA_pinyin_parsg_fm_perm{sub,com};
                Zval_perm(sub,:,com) = 0.5*(log((1+temp)./(1-temp)));       
            end
        end
        [~,p_perm,~,stat_perm] = ttest(Zval_perm,0,'Tail','Right');
        t_perm = reshape(stat_perm.tstat,[size(stat_perm.tstat,2),size(stat_perm.tstat,3)]);
        
        t_all = t_51;
        del_t = union(find(sum(isnan(t_all),2)~=0),find(sum(isnan(t_perm),2)~=0));
        
        t_all(del_t,:)=[];
        t_perm(del_t,:)=[];
        [r1,p1] = corr(t_perm(:,1),t_all(:,1));%logo
        [r2,p2] = corr(t_perm(:,2),t_all(:,2));%pho
        [r3,p3] = corr(t_perm(:,3),t_all(:,3));%sem

        pinyin_perm(perm,1,nsub) = r1;pinyin_perm(perm,2,nsub) = r2;pinyin_perm(perm,3,nsub) = r3;
        pinyin_perm(perm,4,nsub) = p1;pinyin_perm(perm,5,nsub) = p2;pinyin_perm(perm,6,nsub) = p3;
%         fprintf('pinyin Perm %04d of subject number = %02d has finished.\n',perm,nsub);
        clear t_all
    end
end
save pinyin_perm pinyin_perm