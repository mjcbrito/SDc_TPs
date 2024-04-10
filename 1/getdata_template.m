% Sistemas de Decisão
% getdata.m
% collecting 2 dataset from a plant
% {Ue,Ye} and {Uv,Yv}

clear all, close, clc

Ue= idinput(500,'PRBS',[0 0.2],[2.0 4.5]) % Estimation input
Uv= idinput(500,'PRBS',[0 0.1],[2.0 4.5]) % Validation validation
Ts = 0.08; % Sampling time [s]


usbinit % DAQ initialisation

disp('Estimation dataset acquisition') 
for index = 1:length(Ue)
usbwrite(Ue(index),0)
pause(Ts)
Ye(index,1) = usbread(0);
end
usbwrite(0,0), pause(5)
clc
disp('Validation dataset acquisition') 
for index = 1:length(Uv)
usbwrite(Uv(index),0)
pause(Ts)
Yv(index,1)= usbread(0);
end
usbwrite(0,0)
save Ident_dataset.mat Ue Ye Uv Yv -mat
