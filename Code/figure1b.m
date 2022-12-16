clear
clc

load('S1_2_RT.mat');%variable name:meanRT_exp3
meanRT_exp3 = meanRT_exp3(1:44,:);
load('S1_1_ACC.mat');%variable name:meanRB_exp3
meanRB_exp3 = meanRB_exp3(1:44,:);

myc = [155 126 184;174 192 50;219 112 147]/255;% color set

subplot(121)
boxplot(meanRB_exp3,'widths',0.6,'notch','on','colors',colormap(myc));box off;
set(gca,'ylim',[0.75,1.15]);box off;
set(gca,'ytick',[0.75:0.25:1]);
set(gca,'yticklabel',{'75%';'100%'});
set(gca,'xticklabel',{'Chinese word','English word ','Chinese pinyin'});
set(gca,'xticklabelrotation',25);
ylabel('Accuracy Rate');
hold on;
% [h1,p1]=ttest2(meanRB_exp3(:,1),meanRB_exp3(:,2));
% [h2,p2]=ttest2(meanRB_exp3(:,1),meanRB_exp3(:,3));
% [h3,p3]=ttest2(meanRB_exp3(:,2),meanRB_exp3(:,3));
plot([1+0.05,2-0.05],[1.05,1.05],'k');%1vs2
text(1.5,1.06,'NS','HorizontalAlignment','center');
plot([2+0.05,3-0.05,],[1.05,1.05],'k');%2vs3
text(2.5,1.06,'NS','HorizontalAlignment','center');
plot([1+0.05,3-0.05],[1.1,1.1],'k');%1vs3
text(2,1.11,'NS','HorizontalAlignment','center');

subplot(122)
boxplot(meanRT_exp3,'widths',0.6,'notch','on','colors',colormap(myc));box off;
set(gca,'ylim',[500,3500]);box off;
set(gca,'ytick',[0:1000:3000]);
set(gca,'yticklabel',{'0ms','1000ms','2000ms','3000ms'});
set(gca,'xticklabel',{'Chinese word','English word ','Chinese pinyin'});
set(gca,'xticklabelrotation',25);
ylabel('Reaction Time');
hold on;
% [h1,p1]=ttest2(meanRT_exp3(:,1),meanRT_exp3(:,2));
% [h2,p2]=ttest2(meanRT_exp3(:,1),meanRT_exp3(:,3));
% [h3,p3]=ttest2(meanRT_exp3(:,2),meanRT_exp3(:,3));
plot([1+0.05,2-0.05],[2800,2800],'k');%1vs2
text(1.5,2850,'***','HorizontalAlignment','center');
plot([2+0.05,3-0.05,],[2800,2800],'k');%2vs3
text(2.5,2850,'***','HorizontalAlignment','center');
plot([1+0.05,3-0.05],[3100,3100],'k');%1vs3
text(2,3150,'***','HorizontalAlignment','center');
% 8*6 inches, 300 dpi; 12 font size; 1.2 pounds of line weights