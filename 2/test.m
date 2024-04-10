%%% Escrever um script e.g. chamado getdata.m %%%

clear all, close, clc

U = 3.5*ones(750,1); % conjunto de estimação
Ts = 0.08; % Especificar o intervalo de amostragem

usbinit % Inicialização da placa de aquisição

disp('Recolha do conjunto de dados')

for index = 1:length(U)
usbwrite(U(index),0)
pause(Ts)
Y(index,1)= usbread(0)
end

usbwrite(0,0)

save dados.mat U Y -mat