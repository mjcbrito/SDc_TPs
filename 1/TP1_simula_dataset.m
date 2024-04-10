%%% Simula um dataset já obtido
clear all, clc,
load('simulacao.mat')


% Altera a variável r e R
r = 0;
R = [r];

u = zeros(size(Ref));
y = zeros(size(Ref));
error = zeros(size(Ref));
yd = Ref;

disp('A controlar');
for k=3:1:size(Ref)-1
    
    u(k) = ctrlq(B,F,G,P,Q,R,y(k),y(k-1),yd(k));
    
    if u(k) > 5 % Saturação
        u(k) = 5;
    elseif u(k) < 0
        u(k) = 0;
    end
    
    y(k+1) = G(1)*y(k) + G(2)*y(k-1) + B(1)*u(k);
    
    error(k) = y(k) - yd(k);
    
end

subplot(2,1,1), plot(y(1:end)), hold on, plot(Ref)
title('Resposta do sistema em anel fechado')
ylabel('Saida'), xlabel('Amostra')
subplot(2,1,2), plot(u(1:end))
title('Atuacao')
ylabel('acao de controlo'), xlabel('Amostra')

somaErroQuadratico = error'*error
mediaErroQuadratico = somaErroQuadratico / length(error)
