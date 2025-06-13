%% %%%%%%%%%%%%%%  C O N F I G U R A C I O N  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

     %%MODELO DE ESTABILIDAD EN EL DOMINIO DE LA FRECUENCIA%%
                   %%PARA EL HARDWARE IN THE LOOP%%
                            %(TORNEADO)%
                    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc

%% Datos de entrada    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Kf = 2.5e9; % Coeficiente de corte [N/m2]
m = 34.71; % Masa [kg]
k = 3.79e7; % Rigidez [N/m]
c = 979.341; % Amortiguamiento N/(m/s)

%% Parametros dinámicos    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w_n = sqrt(k/m); % Velocidad angular natural [rad/s]
f_n = w_n/(2*pi); % Frecuencia natural [Hz]
dseta = c/(2*m*w_n); %Coeficiente de amortiguamiento (c/c_crítico)

%% Retardo %%   B*w+C    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En el modelo de ejemplo tenemos un retardo de 6 pasos de intergración. 
% Y como T=1e-4 seg., se considera el desfase inicialmente en grados:
B=0; % [º/Hz]
C=-(w_n*6*1e-4*360)/(2*pi); % gradosº
C = 0;


B=B/360;
C=C*2*pi/360;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f_c_inicial = f_n*0.2;
f_c_final = 500;
paso = (f_c_final-f_c_inicial)/10000;%w_c_final/w_c_inicial;
n = 20; % cantidad de ondas

ii=0;
for f_c=f_c_inicial:paso:f_c_final
    w_c = f_c*2*pi; 
    G=FRF1(w_c,w_n,k,dseta,B,C);
     if real(G)<0
        ii=ii+1;
        % Asignamos valor a matriz
        A(ii,1)=f_c;

        % Calculamos profundidad de corte límite
        b_p=-1/(2*Kf*real(G)); 
        A(ii,2)=b_p; 

        % Calculamos desfase entre las ondulaciones de dos pasadas sucesivas
        psi=atan2(imag(G),real(G));
        if psi>0
            psi=psi-2*pi;
        end       
        desf=2*psi+3*pi;
        A(ii,3)=desf;
        
        % Calculamos N. Por cada w_c se sacan varios valores, dependiendo
        % de la cantidad de ondas (n) que se obtengan
        for kk=0:n
            N=120*pi*f_c/(2*pi*kk+desf);
            %N=60*w_c/(2*pi*kk+desf);
            A(ii,5+kk)=N;
         end
     end     
end

%% Seleccionamos valores máximos para mostrar en el gráfico
N_max=5300;
N_min=1200;
b_max=min(A(2:end,2))*15;
a=2*k*dseta/Kf;

%% Gráfico N-b_p
figure
% Lobulos
for kk=0:n
p1 = plot(A(:,5+kk),A(:,2),'k','LineWidth',1);
hold on;
end

% Imprimir Resultados del modelo de referencia.
load('refModelData_NoDelay.mat');
p2 = plot(refModelData_NoDelay(:,1),refModelData_NoDelay(:,2), 'Color', 'red', 'Marker','*');
hold on;
% Imprimir Resultados de las pruebas HIL
load('HilData_NoDelay.mat');
p3 = plot(HilData_NoDelay(:,1),HilData_NoDelay(:,2), 'Color', 'green', 'Marker','+');

% Líneas verticales
for kk=0:n+1
   res=f_n(1)*60/kk;
   line('XData',[res,res],'YData',[0,b_max],'Color','k','LineStyle',':');
end
% Línea horizontal
%line('XData',[N_min,N_max],'YData',[a,a],'Color','k','LineStyle',':');
% Establecemos valores de ejes
axis([N_min N_max 0 b_max]);
% Nombramos ejes y titulo
xlabel('N [rpm]');
ylabel('b_plim [mm]');
title('Stability lobes diagram');
legend([p1 p2 p3], {'Theoretical','Model','HIL'})
hold off;


%Diagrama N-fc
figure
for kk=0:n
plot(A(:,4+kk),A(:,1),'r','LineWidth',2)
hold on
line('XData',[0,N_max],'YData',[f_n,f_n],'Color','k','LineStyle',':')
end
for kk=0:n+1
    r=(2*kk+1)*N_max/120;
    line('XData',[0,N_max],'YData',[0,r],'Color','k','LineStyle',':')
    res=f_n*60/kk;     
    line('XData',[res,res],'YData',[0,f_c_final],'Color','k','LineStyle',':') 
end
axis([N_min N_max 0 f_c_final]);
xlabel('N [rpm]');
ylabel('Chatter frequency [Hz]');
% title('Stability diagram')
hold off