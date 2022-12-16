clear
clc

cwd = '~/current work path';
load('ctrRelSphereSUBs.mat');
load('trilSUB.mat');
%---------------------Mask ID-------------------
load('gfMask.mat');
rmask = load_untouch_nii('rMask_30ROIs.nii');
mask_ref = spm_select('List',pwd,'^rgrayTPM.*\.nii$');
mask_hdrs = spm_vol(mask_ref);
[maskdata,~] = spm_read_vols(mask_hdrs);
maskINDs = find((maskdata>0.2).*...
    (logical(rmask.img)~=0).*...
    (logical(gfMask)~=0));
%------------------Neural RDM Calculation-----------------

Nsub = 51;
for sub = 1:Nsub
    
    cd([cwd sprintf('/Sub%03d',sub)]);
    %1-level results of each stimuli(total 120 .nii files) were packged in each subject's file
    gray_stimuli_neuralap = cell(length(maskINDs),40);
    
    %stimuli 1-40, Chinese word;
    %stimuli 41-80, Chinese pinyin;
    %stimuli 81-120, English word;
    %taking English word as example;
    for stimi = 81:120
        file_filter = sprintf('spmT_%04d',stimi);
        ref = spm_select('List',pwd,['^' file_filter '.*\.nii$']);
        hdrs = spm_vol(ref);
        [data,~] = spm_read_vols(hdrs);
        
        volSize_vox = size(data);
              
        for searchlightVoxel = 1:length(maskINDs)
        
                 fprintf('\n Sub%03d  Stimuli %03d  voxel %01d percent is now calculating\n',sub,stimi,floor(searchlightVoxel*100/length(maskINDs)));
                
                [x,y,z] = ind2sub(volSize_vox,maskINDs(searchlightVoxel));
                
                % compute (sub)indices of (vox)els (c)urrently (ill)uminated by the spherical searchlight
                cIllVoxSUBs=repmat([x,y,z],[size(ctrRelSphereSUBs,1) 1])+ctrRelSphereSUBs;

                % exclude out-of-volume voxels
                outOfVolIs=(cIllVoxSUBs(:,1)<1 | cIllVoxSUBs(:,1)>volSize_vox(1)|...
                            cIllVoxSUBs(:,2)<1 | cIllVoxSUBs(:,2)>volSize_vox(2)|...
                            cIllVoxSUBs(:,3)<1 | cIllVoxSUBs(:,3)>volSize_vox(3));

                cIllVoxSUBs=cIllVoxSUBs(~outOfVolIs,:);

                % list of (IND)ices pointing to (vox)els (c)urrently (ill)uminated by the spherical searchlight
                cIllVox_volINDs=sub2ind(volSize_vox,cIllVoxSUBs(:,1),cIllVoxSUBs(:,2),cIllVoxSUBs(:,3));

                gray_stimuli_neuralap{searchlightVoxel,stimi-80} = data(cIllVox_volINDs);
                
        end
    end
    
    neuralRDM = zeros(length(maskINDs),780);
    for i = 1:length(maskINDs)
    
         fprintf('\n Sub%03d Eng Voxel %01d // 10000 is now calculated\n',sub,floor(i*10000/length(maskINDs)));
    
        for j = 1:780
            [r,p] = corr(gray_stimuli_neuralap{i,trilSUB(j,1)},...
                         gray_stimuli_neuralap{i,trilSUB(j,2)},...
                         'Type','Spearman');
            neuralRDM(i,j) = r;
        end
    
    end
    filename = sprintf('Sub%03d_neuralRDM_EW',sub);
    save(filename,'neuralRDM');
    clear i sti j gray_stimuli_neuralap neuralRDM
    
end
