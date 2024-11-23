%% Plot figure
function[PlotFig, Record] = PlotnSave_nn(ResultFolder,i,SetName, ModelName, set_num, y_m, Y_simuli, IN, CI_UpLim1, CI_LowLim1, CI_UpLim2, CI_LowLim2, residual, time, R_2, aR_2, FPE, AIC, FIT, h, p, ks2stat)
axisYLow = -0.4;%min(IN)-0.01;
%axisYHigh = round(max(y_m),1)+round(max(CI_UpLim),1)+0.01;
axisYHigh = 1.8;%round((max(y_m)+max(CI_UpLim)),1)+0.01;
range_yticks = [floor(axisYLow):0.1:round(axisYHigh)];
ytick_labels = compose('%0.1f', range_yticks);
fz = 8.5; %font size (X-axis)
Lfz = 12; %axis label font size

PlotFig = figure();
%set(0, 'DefaultFigureVisible', 'off');
hold on
fig = gobjects(4, 1);
set(gcf,'Position',[1000 10 1000 500]) %[left bottom width height]
yyaxis('left')
fig(1) = errorbar(time, y_m, CI_LowLim1, CI_UpLim1,'Color','green','CapSize',2,'DisplayName', '95% CI');
fig(2) = errorbar(time, y_m, CI_LowLim2, CI_UpLim2,'Color','cyan','CapSize',2,'DisplayName', '75% CI');
fig(3) = plot(time,Y_simuli,'-k','LineWidth',2,'DisplayName', 'Prediction');
fig(4) = plot(time, y_m,'-','Color',[0.4660, 0.6740, 0.1880],'LineWidth',2,'DisplayName', 'Output');
fig(6) = plot(time, residual,'-','Color',[0.4375,0.5,0.5625],'LineWidth',2,'DisplayName', 'Residual');
ax = gca;
ax.YColor=[0.4660, 0.6740, 0.1880];
axis([0 time(end) axisYLow axisYHigh])
yticks(range_yticks)
yticklabels = ytick_labels;
set(gca,'FontSize',fz,'XMinorTick','on','YMinorTick','on')
xlabel('Time (min.)','FontSize',Lfz)
ylabel('${\it Gal1}_{\mathrm{Gfp}}$ fluorescence (a.u.)','FontSize',Lfz,'Interpreter','latex')

yyaxis('right')
fig(5) = plot(time,IN,'Color','r','LineWidth',2,'DisplayName', 'Input');
set(gca,'XMinorTick','on','YMinorTick','on')
ax.YColor=[1,0,0];
axis([0 time(end) axisYLow axisYHigh])
yticks(range_yticks)
yticklabels = ytick_labels;
ylabel('Red fluorescence (a.u.)','FontSize',Lfz,'Interpreter','latex')
xline(180,'--b');

figXAx = get(gca,'XAxis');
xl = xlim;
figXAx.MinorTickValues = xl(1):50:xl(2);
figXAx.TickValues = xl(1):100:xl(2);

formatSpec = '%.4f';
title(['',ModelName,' of ',SetName,', FIT (%) = ', num2str(FIT,formatSpec),''],'FontSize',12)
legend(fig([5,4,3,6,2,1]))

scale = 2;
paperunits = 'centimeters';
filewidth = 15; %cm %10
fileheight = 5; %cm %5
size = [filewidth fileheight]*scale;
set(gcf,'paperunits',paperunits,'paperposition',[-2.65 -0.05 size]); %[-1.3 0.05 size][-2.7 -0.05 size]
set(gcf, 'PaperSize', [25.7,9.8]); %[18.1,9.9][25.8,9.8]

hold off

%Save figure as PDF
% Fig = ['/Users/chen/Desktop/Td0_',set_num,'_',ModelName,'_',SetName,'_',i,'_valid.pdf'];
% print(gcf,Fig,'-dpdf','-r300')
chari = string(i);
ith = num2str(i);
figfile = string([set_num, ModelName, SetName, chari]);
FigFile = char(join(figfile,'_'));
Fig = ['/Users/chen/Desktop/Td0_',FigFile,'_valid.fig'];
savefig(Fig)

FigPdf = ['/Users/chen/Desktop/Td0_',FigFile,'_valid.pdf'];
print(gcf,FigPdf,'-dpdf','-r300')

% Record results
Record = struct('SetName',SetName, 'valid_ModelOutput',Y_simuli,...
                'valid_R_sqr',R_2, 'valid_adj_R_sqr',aR_2, 'valid_FPE',FPE,...
                'valid_AIC',AIC, 'valid_FIT',FIT, 'KS_h',h, 'KS_p',p, 'KS_stat',ks2stat);
end