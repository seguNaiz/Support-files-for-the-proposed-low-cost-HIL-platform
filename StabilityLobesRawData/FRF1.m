function [G] = FRF1(wc , wn , k , dseta, B, C)
%%%%%%%%%%%%CALCULO DE LA FRF%%%%%%%%%%%%%%%%

%G=FRF
%w=frecuencia de chatter actual [rad/s]
%wn=matriz de frecuencias naturales [rad/s]
%k=matriz de rigideces [N/mm]
%dseta=matriz de amortiguamientos
%B= pendiente del retardo
%C= valor del retardo a frecuencia cero

G=0;;
for ii=1:length(wn)
    
    G=G+(1/k(ii))*((1-(wc/wn(ii))^2)/((1-(wc/wn(ii))^2)^2+4*dseta(ii)^2*(wc/wn(ii))^2)-i*(2*dseta(ii)*(wc/wn(ii))/((1-(wc/wn(ii))^2)^2+4*dseta(ii)^2*(wc/wn(ii))^2)))*exp((B*wc+C)*i);
  
end