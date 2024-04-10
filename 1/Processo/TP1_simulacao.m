%%% Simula um modelo
clear all, clc,
load('Dados_Processo_0_2.mat')



subplot(2,1,1), plot(y(1:end)), hold on, plot(Ref)
title('Resposta do sistema em anel fechado')
ylabel('Saida'), xlabel('Amostra')
subplot(2,1,2), plot(u(1:end))
title('Atuacao')
ylabel('acao de controlo'), xlabel('Amostra')

somaErroQuadratico = error'*error
mediaErroQuadratico = somaErroQuadratico / length(error)
% save('simulacao_0_01.mat')
