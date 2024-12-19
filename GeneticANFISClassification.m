%% Genetic Fuzzy and Genetic ANFIS Classification
% Okay, what about combining evolutionary algorithms with fuzzy logic and
% ANFIS for classification? Well, let’s push some limits!!! Data is
% consisted of 50 samples with 5 features and 5 classes. You can put your
% data in the system and run it. You have to play with parameters depending
% on your data and system. Right now, you can just run the code and see the
% result. You have to wait for Genetic Algorithm to finish training. 
% This code is part of the following project. So, please cite them after use:
% Mousavi, Seyed Muhammad Hossein, et al. "A PSO fuzzy-expert system: As an assistant for specifying the acceptance by NOET measures, at PH. D level." 2017 Artificial Intelligence and Signal Processing Conference (AISP). IEEE, 2017.
% Mousavi, Seyed Muhammad Hossein, S. Younes MiriNezhad, and Mir Hossein Dezfoulian. "Galaxy gravity optimization (GGO) an algorithm for optimization, inspired by comets life cycle." 2017 Artificial Intelligence and Signal Processing Conference (AISP). IEEE, 2017.
% Enjoy the code and feel free to ask your question from me:
% Email: mosavi.a.i.buali@gmail.com
% Seyed Muhammad Hossein Mousavi
% CODING IS LOVE - Stay safe and be happy :)

%% Lets Do This
% Clearing the Space
clc;
clear;
close all;
warning('off');
%% Start The System 
% Loading Data
load evolve.mat
% Shuffling or Swapping Rows (Diverse Result in Each Run)
random_x = dat(randperm(size(dat, 1)), :);
% Deviding Data and Labels
traininput=random_x(:,1:end-1);
traintarget=random_x(:,end);
% Creating Final Struct
data.TrainInputs=traininput;
data.TrainTargets=traintarget;

%% Training Stage
% Generating the FIS
Fuzzy=FISCreation(data,3);
% Tarin Using ANFIS Method
ANFIS=ANFISTrain(Fuzzy,data);
% Tarining By Genetic Algorithm (GA-Fuzzy)
[GA_Fuzzy G_FUZ_results]=GeneticTrain(Fuzzy,data);
% Tarining By Genetic Algorithm (GA-ANFIS)
[GA_ANFIS G_ANF_results]=GeneticTrain(ANFIS,data);
figure;
plotfis(Fuzzy)
figure;
plotfis(ANFIS)
figure;
plotfis(GA_Fuzzy)
figure;
plotfis(GA_ANFIS)
% figure;
% plotmf(GA_ANFIS,'input',3)

%% What Is Achieved In Visual.
BestGAFUZ=G_FUZ_results.BestCost;
BestGAANF=G_ANF_results.BestCost;
% Plot Training
figure;
set(gcf, 'Position',  [300, 50, 600, 600])
subplot(2,1,1)
plot(BestGAFUZ,'-.','LineWidth',3,'MarkerSize',12,'MarkerEdgeColor','b',...
    'Color',[0.3,0,0.9]);title('Fuzzy Genetic Algorithm','Color','r');
xlabel('GA Iteration Number','FontSize',12,'FontWeight','bold','Color',[0.3,0,0.9]);
ylabel('GA Best Cost Result','FontSize',12,'FontWeight','bold','Color',[0.3,0,0.9]);
legend({'Fuzzy GA Train'});
subplot(2,1,2)
plot(BestGAANF,'-.','LineWidth',3,'MarkerSize',12,'MarkerEdgeColor','b',...
    'Color',[0.6,0,0.9]);title('ANFIS Genetic Algorithm','Color','r');
xlabel('GA Iteration Number','FontSize',12,'FontWeight','bold','Color',[0.6,0,0.9]);
ylabel('GA Best Cost Result','FontSize',12,'FontWeight','bold','Color',[0.6,0,0.9]);
legend({'ANFIS GA Train'});

% Plot Statistics
    figure;
    set(gcf, 'Position',  [5, 50, 800, 200])
FyzzyOutputs=evalfis(data.TrainInputs,Fuzzy);
PlotVisual(data.TrainTargets,FyzzyOutputs,'Fuzzy');
    xlabel('Fuzzy','FontSize',14,'FontWeight','bold','Color',[0.9,0.1,0.1]);
    figure;
    set(gcf, 'Position',  [50, 100, 800, 200])
ANFISOutputs=evalfis(data.TrainInputs,ANFIS);
PlotVisual(data.TrainTargets,ANFISOutputs,'ANFIS');
    xlabel('ANFIS','FontSize',14,'FontWeight','bold','Color',[0.9,0.1,0.1]);
    figure;
    set(gcf, 'Position',  [150, 150, 800, 200])
GAFuzzyOutputs=evalfis(data.TrainInputs,GA_Fuzzy);
PlotVisual(data.TrainTargets,GAFuzzyOutputs,'GA Fuzzy');
    xlabel('GA Fuzzy','FontSize',14,'FontWeight','bold','Color',[0.9,0.1,0.1]);
    figure;
    set(gcf, 'Position',  [200, 200, 800, 200])
GAANFISOutputs=evalfis(data.TrainInputs,GA_ANFIS);
PlotVisual(data.TrainTargets,GAANFISOutputs,'GA ANFIS');
    xlabel('GA ANFIS','FontSize',14,'FontWeight','bold','Color',[0.9,0.1,0.1]);

%% Calculating Classification Accuracy
AllTar=data.TrainTargets;
% Generating Outputs
FORound=round(FyzzyOutputs);
AORound=round(ANFISOutputs);
GFORound=round(GAFuzzyOutputs);
GAORound=round(GAANFISOutputs);
sizedata=size(FORound);sizedata=sizedata(1,1);
classsize=max(AllTar);
for i=1 : sizedata
    if FORound(i) > classsize
        FORound(i)=classsize;
    end;end;
for i=1 : sizedata
    if AORound(i) > classsize
        AORound(i)=classsize;
    end;end;
for i=1 : sizedata
    if GFORound(i) > classsize
        GFORound(i)=classsize;
    end;end;
for i=1 : sizedata
    if GAORound(i) > classsize
        GAORound(i)=classsize;
    end;end;
% Calculating Accuracy
% Fuzzy Accuracy
ctfuzz=0;
for i = 1 : sizedata(1,1)
if FORound(i) ~= AllTar(i)
    ctfuzz=ctfuzz+1;
end;end;
finfuzz=ctfuzz*100/ sizedata;  
FuzzyAccuracy=(100-finfuzz);
% ANFIS Accuracy
ctanf=0;
for i = 1 : sizedata(1,1)
if AORound(i) ~= AllTar(i)
    ctanf=ctanf+1;
end;end;
finanf=ctanf*100/ sizedata; 
ANFISAccuracy=(100-finanf);
% GA Fuzzy Accuracy
ctgf=0;
for i = 1 : sizedata(1,1)
if GFORound(i) ~= AllTar(i)
    ctgf=ctgf+1;
end;end;
fingf=ctgf*100/ sizedata; 
GFAccuracy=(100-fingf);
% GA ANFIS Accuracy
ctganf=0;
for i = 1 : sizedata(1,1)
if GAORound(i) ~= AllTar(i)
    ctganf=ctganf+1;
end;end;
finganf=ctganf*100/ sizedata; 
GANFAccuracy=(100-finganf);
% Confusion Matrixes
% Extracting Errors
FOMSE=mse(AllTar,FORound);
AOMSE=mse(AllTar,AORound);
GFOMSE=mse(AllTar,GFORound);
GAOMSE=mse(AllTar,GAORound);
figure
set(gcf, 'Position',  [50, 100, 1300, 300])
subplot(1,4,1)
cm1 = confusionchart(AllTar,FORound);
cm1.Title = (['Fuzzy Classification =  ' num2str(FuzzyAccuracy-FOMSE) '%']);
subplot(1,4,2)
cm2 = confusionchart(AllTar,AORound);
cm2.Title = (['ANFIS Classification =  ' num2str(ANFISAccuracy-AOMSE) '%']);
subplot(1,4,3)
cm3 = confusionchart(AllTar,GFORound);
cm3.Title = (['Genetic Fuzzy Classification =  ' num2str(GFAccuracy-GFOMSE) '%']);
subplot(1,4,4)
cm4 = confusionchart(AllTar,GAORound);
cm4.Title = (['Genetic ANFIS Classification =  ' num2str(GANFAccuracy-GAOMSE) '%']);
% Print Accuracy
fprintf('The Fuzzy Classification Accuracy is = %0.4f.\n',FuzzyAccuracy-FOMSE)
fprintf('The ANFIS Classification Accuracy is = %0.4f.\n',ANFISAccuracy-AOMSE)
fprintf('The Genetic Fuzzy Classification Accuracy is = %0.4f.\n',GFAccuracy-GFOMSE)
fprintf('The Genetic ANFIS Classification Accuracy is = %0.4f.\n',GANFAccuracy-GAOMSE)

