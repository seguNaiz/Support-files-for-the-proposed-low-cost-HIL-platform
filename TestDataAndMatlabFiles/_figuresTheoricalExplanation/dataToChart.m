fig = figure;

% Gráfico 1: 
subplot(3, 1, 1);
plot(stableResponse);
subtitle("Stable response");
xlim([0 50000]);
ylim([-0.15 0.15]);

% Gráfico 2: All in Zedboard (arriba a la derecha)
subplot(3, 1, 2);
plot(instableResponse);
subtitle("Unstable response");
xlim([0 50000]);
ylim([-2 2]);

% Gráfico 3: Co-simulation (abajo a la izquierda)
subplot(3, 1, 3);
plot(criticalResponse);
subtitle("Critically stable response");
xlim([0 50000]);
ylim([-0.15 0.15]);



% Titulo y ejes generales
sgtitle("Possible responses");

han=axes(fig,'visible','off'); 
han.Title.Visible='off';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Amplitude');
xlabel(han,'Time (ms)');
% title(han,'yourTitle');



%%%%%%%%%%%%%%%%%%%%%
fig = figure;
plot(stableResponse);
subtitle("First pass of the tool over the workpiece");
xlim([1900 2500]);
ylim([-0.15 0.15]);

han=axes(fig,'visible','off'); 
han.Title.Visible='off';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Amplitude');
xlabel(han,'Time (ms)');




