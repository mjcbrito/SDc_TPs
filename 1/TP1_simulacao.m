%%% Simula um modelo
clear all, clc,
load('arx211.mat')

N = 150;
Ref= [3.0*ones(1,N), 4.0*ones(1,N), 3.0*ones(1,N), 2.5*ones(1,N), 3.5*ones(1,N)]'; % Definir o sinal de referência

A = arx211.A;
B = arx211.B(2);
Ts = arx211.Ts;

P = 1;
Q = 1;

[F, G] = deconv([1 0 0], A);
G = G(2:end);

r = 0.3;
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
save('simulacao_0_3.mat')
