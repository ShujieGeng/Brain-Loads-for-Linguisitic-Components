# Brain-Loads-for-Linguisitic-Components
Code and Data used in our paper entitled "Intersecting distributed networks support convergent linguistic functioning across different languages in bilinguals" published in Communications Biology.

Citing our paper would be greatly appreciated if you use these codes or data. 
  
STEPS :  
Step1: Participant’s behavioral responses in experiment.  
Step2: Brain activations for CW, EW and CP.  
Step3: Behavioral RDMs of Logo-grapheme, Phonology and Semantics for CW, EW and CP.  
Step4: Neural RDMs generation.  
Step5: Representational Similarity Analysis.  
Step6: Visualization of Brain Loads :   
	BrainNet Viewer(Xia et al., 2013, http://www.nitrc.org/projects/bnv/)  
	MRIcroGL(https://github.com/rordenlab/MRIcroGL)  
Step7: Support Vector Regression  
Step8: Associations between Brain loads and reaction time  
Step9: Validations

Abbreviations:   
CW-Chinese word;EW-English word;CP-Chinese pinyin  
Logo-Logo-grapheme;Pho-Phonology;Sem-Semantics  

## DATA :  
  S1_1_ACC.mat  S1_2_RT.mat  
  S2_1_CW_2level_fmask_fdr005c10.nii  S2_2_EW_2level_fmask_fdr005c10.nii S2_3_CP_2level_fmask_fdr005c10.nii  
  S3_1_LogoRDM_CW.mat  
  S3_1_LogoRDM_EW.mat  
  S3_1_LogoRDM_CP.mat  
  S3_2_PhoRDM_CW.mat  
  S3_2_PhoRDM_EW.mat  
  S3_2_PhoRDM_CP.mat  
  S3_3_SemRDM_CW.mat  
  S3_3_SemRDM_EW.mat  
  S3_3_SemRDM_CP.mat  
  S5_1_BrainLoad_Logo.nii  
  S5_1_BrainLoad_Pho.nii  
  S5_1_BrainLoad_Sem.nii  
  S5_2_BrainLoad_CW.nii  
  S5_2_BrainLoad_EW.nii  
  S5_2_BrainLoad_CP.nii  
  S5_3_rsaZ_CW.nii  
  S5_3_rsaZ_EW.nii  
  S5_3_rsaZ_CP.nii  
  S5_4_BrainLoad_ROI.xlsx  
  S7_1_y_pred.mat  
  S7_1_y_pred_logo.mat  
  S7_1_y_pred_pho.mat  
  S7_1_y_pred_sem.mat  
  S7_2_bestK_rbf.mat  
  S7_2_rmse_all_rbf.mat  
  S7_2_rmse_Nminus1_rbf.mat  
  S9_1_CW_perm.mat    
  S9_1_EW_perm.mat  
  S9_1_CP_perm.mat 
## CODE :  
  S4_NeuralRDM_gene.m  
  S5_RSA_gene.m  
  S5_RSA_mining.m  
  S7_1_brainload_svr.py  
  S7_2_brainload_svrREF.py  
  S8_LMEmodel.m  
  figure1b.m  
  figure3b.m  
  figure4a.m  
  figure4b.m  
  figure6b.m  
  figure6cd.m  
  figure7.m  
  figure8b.m  
  figureS3.m  
  figureS3perm_gene.m  
