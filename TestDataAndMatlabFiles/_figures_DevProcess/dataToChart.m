% clear; close all;
% load("alineamiento.mat");
% figure;
% f(1) = plot(data_reference,'DisplayName', "Reference model", 'Color', "r");
% hold on;
% f(2) = plot(data_ZedB,'DisplayName', "All in Zedboard", 'Color', "g");
% hold on;
% f(3) = plot(data_CoSim,'DisplayName', "Co-simulation", 'Color', "b");
% 
% legend;
% xlabel('Time (ms)');
% ylabel('Amplitude');
% title('Raw Shaker command');
% xlim([0 8000]);

% Asumiendo que ya tienes tus datos generados para cada gráfico

% Crear una nueva figura
fig = figure;

% Gráfico 1: Reference Model (arriba a la izquierda)
subplot(2, 2, 1);
plot(data_reference,'DisplayName', "Reference model");
subtitle('Reference model');
xlim([1000 8000]);

% Gráfico 2: All in Zedboard (arriba a la derecha)
subplot(2, 2, 2);
plot(data_ZedB,'DisplayName', "All in Zedboard");
subtitle('All in Zedboard');
xlim([1000 8000]);

% Gráfico 3: Co-simulation (abajo a la izquierda)
subplot(2, 2, 3);
plot(data_CoSim,'DisplayName', "HIL");
subtitle('HIL');
xlim([1000 8000]);

% Gráfico 4: Todos en uno (abajo a la derecha)
subplot(2, 2, 4);
f(1) = plot(data_reference,'DisplayName', "Reference model");
hold on;
f(2) = plot(data_ZedB,'DisplayName', "All in Zedboard");
hold on;
f(3) = plot(data_CoSim,'DisplayName', "HIL");
subtitle('Comparison and zoom');
xlim([1900 2400]);
legend;

% Titulo y ejes generales
sgtitle('Development process results');

han=axes(fig,'visible','off'); 
han.Title.Visible='off';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Y_0');
xlabel(han,'Time (ms)');
title(han,'yourTitle');

% Ajustar el tamaño de la figura si es necesario
%set(gcf, 'Position', [100, 100, 1200, 800]); % ajustar el tamaño de la figura





