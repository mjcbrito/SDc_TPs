%% Dados 1
clear all; clc;
load('dataset_optimo.mat');

t = 1:1:kfinal+1;

figure(1)
subplot(2,1,1),plot(t,y,'-r'),hold on, plot(t,Ref,'-. k'),
title('\textbf{Resposta em anel fechado}','Interpreter','latex')
% legend('saída óptima','Referência')
ylabel({'$y(k)$'},'Interpreter','latex')
xlabel('Tempo $[s]$','Interpreter','latex')
subplot(2,1,2),stairs(t(1:end),u,'r-'),
xlabel('Tempo $[s]$','Interpreter','latex')
ylabel({'$u(k)$'},'Interpreter','latex')

%% Dados 2
clear all; clc;
load('dataset_optimo_processo_2.mat');

t = 1:1:kfinal+1;

figure(1)
subplot(2,1,1),plot(t,y,'-b'),hold on, plot(t,Ref,'-. k'),
title('\textbf{Resposta em anel fechado}','Interpreter','latex')
% legend('saída óptima','Referência')
ylabel({'$y(k)$'},'Interpreter','latex')
xlabel('Tempo $[s]$','Interpreter','latex')
subplot(2,1,2),stairs(t(1:end),u,'b-'),
xlabel('Tempo $[s]$','Interpreter','latex')
ylabel({'$u(k)$'},'Interpreter','latex')

%% Dados 3
clear all; clc;
load('dataset_optimo_processo_3.mat');

t = 1:1:kfinal+1;

figure(1)
subplot(2,1,1),plot(t,y,'-c'),hold on, plot(t,Ref,'-. k'),
title('\textbf{Resposta em anel fechado}','Interpreter','latex')
% legend('saída óptima','Referência')
ylabel({'$y(k)$'},'Interpreter','latex')
xlabel('Tempo $[s]$','Interpreter','latex')
subplot(2,1,2),stairs(t(1:end),u,'c-'),
xlabel('Tempo $[s]$','Interpreter','latex')
ylabel({'$u(k)$'},'Interpreter','latex')

% %% Dados 4
% clear all; clc;
% load('dataset_optimo_processo_V4.mat');
% 
% t = 1:1:kfinal+1;
% 
% figure(1)
% subplot(2,1,1),plot(t,y,'-g'),hold on, plot(t,Ref,'-. k'),
% title('\textbf{Resposta em anel fechado}','Interpreter','latex')
% % legend('saída óptima','Referência')
% ylabel({'$y(k)$'},'Interpreter','latex')
% xlabel('Tempo $[s]$','Interpreter','latex')
% subplot(2,1,2),stairs(t(1:end),u,'g-'),
% xlabel('Tempo $[s]$','Interpreter','latex')
% ylabel({'$u(k)$'},'Interpreter','latex')
% 
% %% Dados 5
% clear all; clc;
% load('dataset_optimo_processo_V5.mat');
% 
% t = 1:1:kfinal+1;
% 
% figure(1)
% subplot(2,1,1),plot(t, y, '-y', 'LineWidth', 1.5),hold on,plot(t, Ref, '-.k'),hold off,
% 
% title('\textbf{Resposta em anel fechado}','Interpreter','latex')
% % legend('saída óptima','Referência')
% ylabel({'$y(k)$'},'Interpreter','latex')
% xlabel('Tempo $[s]$','Interpreter','latex')
% subplot(2,1,2),stairs(t(1:end),u,'y-'),
% xlabel('Tempo $[s]$','Interpreter','latex')
% ylabel({'$u(k)$'},'Interpreter','latex')