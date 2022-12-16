%%
clear
clc

load('S3_1_LogoRDM_CW.mat');
load('S3_1_LogoRDM_EW.mat');
load('S3_1_LogoRDM_CP.mat');

N = length(RDM_logoExp3);
vec_RDM_logo = zeros([1,N*(N-1)/2]);
vec_RDM_phon = zeros([1,N*(N-1)/2]);
vec_RDM_w2v = zeros([1,N*(N-1)/2]);
for i=1:N
    l = (i-1)*(2*N-i)/2+1;
    vec_RDM_logo(l:(l+N-i-1)) = RDM_logoExp3((i+1):end,i);
    vec_RDM_phon(l:(l+N-i-1)) = RDM_PhonologyExp3((i+1):end,i);
    vec_RDM_w2v(l:(l+N-i-1)) = RDM_w2vExp3_Chinese_sg((i+1):end,i);
end

Nsub = 51;

RSA_Chi_parsg_fm = cell(Nsub,6);
for sub = 1:Nsub
    
    fname = sprintf('Sub%03d_neuralRDM_CW.mat',sub);
    load(fname);

    [r1,p1] = partialcorr( neuralRDM',vec_RDM_logo',cat(2,vec_RDM_phon',vec_RDM_w2v'),'type','Spearman','tail','right');
    [r2,p2] = partialcorr( neuralRDM',vec_RDM_phon',cat(2,vec_RDM_logo',vec_RDM_w2v'),'type','Spearman','tail','right');
    [r3,p3] = partialcorr( neuralRDM',vec_RDM_w2v',cat(2,vec_RDM_logo',vec_RDM_phon'),'type','Spearman','tail','right');
    
    RSA_Chi_parsg_fm{sub,1} = r1;RSA_Chi_parsg_fm{sub,4} = p1;
    RSA_Chi_parsg_fm{sub,2} = r2;RSA_Chi_parsg_fm{sub,5} = p2;
    RSA_Chi_parsg_fm{sub,3} = r3;RSA_Chi_parsg_fm{sub,6} = p3;

    fprintf('Sub%03d RSA has been calculated.\n',sub);
    
end

save RSA_CW RSA_CW
