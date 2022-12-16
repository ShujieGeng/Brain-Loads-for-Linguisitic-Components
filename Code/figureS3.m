%%
clear
clc

load('Chi_perm.mat');
load('Eng_perm.mat');
load('pinyin_perm.mat');

Chi_mean = zeros(3,21);
Chi_yl = zeros(3,21);
Chi_yh = zeros(3,21);
for num = 1:21
    [mu,sigma,muci,sigmaci] = normfit(Chi_perm(:,1:3,num));
    Chi_mean(:,num) = mu;
    for i = 1:3
        Chi_yl(i,num) = mu(1,i) - sigmaci(1,i);
        Chi_yh(i,num) = mu(1,i) + sigmaci(2,i);
    end
end

Eng_mean = zeros(3,21);
Eng_yl = zeros(3,21);
Eng_yh = zeros(3,21);
for num = 1:21
    [mu,sigma,muci,sigmaci] = normfit(Eng_perm(:,1:3,num));
    Eng_mean(:,num) = mu;
    for i = 1:3
        Eng_yl(i,num) = mu(1,i) - sigmaci(1,i);
        Eng_yh(i,num) = mu(1,i) + sigmaci(2,i);
    end
end

Pin_mean = zeros(3,21);
Pin_yl = zeros(3,21);
Pin_yh = zeros(3,21);
for num = 1:21
    [mu,sigma,muci,sigmaci] = normfit(pinyin_perm(:,1:3,num));
    Pin_mean(:,num) = mu;
    for i = 1:3
        Pin_yl(i,num) = mu(1,i) - sigmaci(1,i);
        Pin_yh(i,num) = mu(1,i) + sigmaci(2,i);
    end
end

myc = [60 135 255;77 170 15;255 110 25.5]/255;
subplot(1,3,1);
for i = 1:3
    x = 31:1:51;
    y = Chi_mean(i,:);
    yu = Chi_yh(i,:);
    yl = Chi_yl(i,:);

    fill([x fliplr(x)],[yu fliplr(yl)],...
        myc(i,:),'linestyle','non','FaceAlpha',0.15);hold on;   
    axis([31 51 .61 1.01]);
    set(gca,'ytick',[.6:.1:1.01]);
    set(gca,'xtick',[30:10:52]);
    plot(x,y,'color',myc(i,:));box off;
    
    if i==3
        title('Chinese word');
        ylabel('Correlations');
        xlabel('Number of Subjects');
    end
end
subplot(1,3,2);
for i = 1:3
    x = 31:1:51;
    y = Eng_mean(i,:);
    yu = Eng_yh(i,:);
    yl = Eng_yl(i,:);

    fill([x fliplr(x)],[yu fliplr(yl)],...
        myc(i,:),'linestyle','non','FaceAlpha',0.15);hold on;
    plot(x,y,'color',myc(i,:));box off;
    axis([31 51 .61 1.01]);
    set(gca,'ytick',[.6:.1:1.01]);
    set(gca,'xtick',[30:10:52]);
    if i==3
        title('English word');
%         ylabel('Correlation between subgroup and group');
        xlabel('Number of Subjects');
    end
end
subplot(1,3,3);
for i = 1:3
    x = 31:1:51;
    y = Pin_mean(i,:);
    yu = Pin_yh(i,:);
    yl = Pin_yl(i,:);

    fill([x fliplr(x)],[yu fliplr(yl)],...
        myc(i,:),'linestyle','non','FaceAlpha',0.15);hold on;
    plot(x,y,'color',myc(i,:));box off;
    axis([31 51 .61 1.01]);
    set(gca,'ytick',[.6:.1:1.01]);
    set(gca,'xtick',[30:10:52]);
    if i==3
        title('Chinese pinyin');
%         ylabel('Correlation between subgroup and group');
        xlabel('Number of Subjects');
    end
end

%15*4 inches, 600 dpi, font 12 points, line 1.2pound