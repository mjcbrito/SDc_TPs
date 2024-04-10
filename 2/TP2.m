clear all; clc;
load('dataset_optimo_processo.mat');

subplot(2,1,1),plot(t,y,'-r',t,Ref,'-. k'),
title('\textbf{Resposta em anel fechado}','Interpreter','latex')
legend('saída óptima','Referência', 'saída subóptima')
ylabel({'$y(k)$'},'Interpreter','latex')
xlabel('Tempo $[s]$','Interpreter','latex')
subplot(2,1,2),stairs(t(1:end-1),u,'r-'), hold on, stairs(t(1:end-1),usub,'g-'), hold off
xlabel('Tempo $[s]$','Interpreter','latex')
ylabel({'$u(k)$'},'Interpreter','latex')


