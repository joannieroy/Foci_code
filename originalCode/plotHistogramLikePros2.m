clear
load('workspaceInduced.mat')
clear area
close all

times={'45','60',  '75', '90', '120'};
names={'control', 'fast', 'fast2'};

myData=cell(numel(names), numel(times));
for itName=1:numel(names)
    for itTime=1:numel(times)
        eval(['myData{itName, itTime}=' names{itName} 'Temps' times{itTime} ';']);
    end
end

normHist=cell(numel(names), 1);

for itTime=1:numel(times)
    for itNames=1:numel(names)
%         [normHist{itNames}]=ksdensity(myData{itNames, itTime},linspace(0,.5,40),'BoundaryCorrection','reflection', 'Bandwidth', .05, 'Function','pdf');
        [normHist{itNames}]=ksdensity(myData{itNames, itTime},linspace(0,40,100));
    end
        figure1 = figure(1);
        axes1 = axes('Parent',figure1);
        a1=area(linspace(0,40,100),normHist{1});
        a1.FaceColor='red';
        alpha(.4)
        hold on
        a2=area(linspace(0,40,100),normHist{2});
        a2.FaceColor='blue';
        alpha(.4)
        a3=area(linspace(0,40,100),normHist{3});
        a3.FaceColor='green';
        alpha(.4)

        if itTime==5
            axes1.XLabel.String='Number of foci';
            axes1.XLabel.FontSize=30;
        end
        axes1.YLabel.String='Cell fraction';
        axes1.XLabel.FontSize=30;
        axes1.XLim=[0 40];
        axes1.YLim=[0 0.15];
        axes1.FontSize=20;
        axes1.XTick=[0 10 20 30];
        
        lgd=legend('Parental cells', 'Population 1', 'Population 2','Location', 'northeast', 'Box', 'on');
        lgd.FontSize=15;
        lgd.Title.String=[times{itTime} ' minutes after IR'];
        hold off
        
        saveas(figure1,['nonInducedHistogramsPositivosTEST' times{itTime} '.tif'],'tiff')
        
      close(1)

end


