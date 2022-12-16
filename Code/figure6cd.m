%%
clear
clc
roiLabel = {'OperIFG','TriIFG','Precentral',...
    'SM','STG','TP','MTG',...
    'Angular','MFG','IPG','SMG','Fusiform'};
data = xlsread('S5_4_BrainLoad_ROI.xlsx','Sheet5','N1:S12');
myc = [60 135 255;77 170 15;255 110 25.5]/255;

%---------------figure6c-------------
figure;
for roi = 1:7
    dataroi = cat(1,data(roi,1:3),data(roi,4:6));
    [~,locb] = ismember(sort(dataroi(2,:)),dataroi(2,:));
    %equal percentage should be changed mamually
    subplot(1,7,roi);
    h = bar(dataroi(:,locb),0.7,'stacked');box off;
    set(gca,'xticklabel',{'Chinese word','English word'});
    set(gca,'xticklabelrotation',25);
	set(gca,'ytick',[0:0.5:1]);
    if roi == 1
     set(gca,'yticklabel',{'0','50%','100%'});
    else
     set(gca,'yticklabel',[ ]);
    end
    for i=1:3
        h(i).FaceColor = myc(locb(i),:);
        h(i).EdgeColor = [1 1 1];
    end
    title(roiLabel{roi});
end
% 12*2.5 inches 600dpi scale with minimum of 7.5 points 1.2pounds
%---------------figure6d-------------
figure;
for roi = 8:12
    dataroi = cat(1,data(roi,1:3),data(roi,4:6));
    [~,locb] = ismember(sort(dataroi(2,:)),dataroi(2,:));
    %equal percentage should be changed mamually
    subplot(1,5,roi-7);
    h = bar(dataroi(:,locb),0.7,'stacked');box off;
    set(gca,'xticklabel',{'Chinese word','English word'});
    set(gca,'xticklabelrotation',25);
	set(gca,'ytick',[0:0.5:1]);
    if roi == 8
     set(gca,'yticklabel',{'0','50%','100%'});
    else
     set(gca,'yticklabel',[ ]);
    end
    for i=1:3
        h(i).FaceColor = myc(locb(i),:);
        h(i).EdgeColor = [1 1 1];
    end
    title(roiLabel{roi});
%     print(gcf,'-djpeg',[roiLabel{roi} '1.jpg'],'-r300');
%     print(gcf,'-djpeg',[roiLabel{roi} '.jpg'],'-r300');
end
% 8*2.5 inches 600dpi scale with minimum of 7.5 points 1.2pounds

