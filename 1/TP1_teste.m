%%% Teste no processo real
clear all, clc,
load('arx211.mat')

N = 150;
Ref= [3.0*ones(1,N), 4.0*ones(1,N), 3.0*ones(1,N), 2.5*ones(1,N), 3.5*ones(1,N)]'; % Definir o sinal de referência

A = [1 -1.3694 0.4811];
B = [0.1325];
Ts = 0.08;

P = 1;
Q = 1;

[F, G] = deconv([1 0 0], A);
G = G(2:end);

r = 0.01;
R = [r];

u = zeros(size(Ref));
y = zeros(size(Ref));
error = zeros(size(Ref));
yd = Ref;

usbinit % Inicialização da placa de aquisição

disp('A controlar');
for k=1:1:size(Ref)-1
    y(k)= usbread(0);
    tic % Inicia cronómetro
    
    if k < 3
        u(k) = yd(k);
    else
        u(k) = ctrlq(B,F,G,P,Q,R,y(k),y(k-1),yd(k));
    end
    
    if u(k) > 5 % Saturação
        u(k) = 5;
    elseif u(k) < 0
        u(k) = 0;
    end
    
    usbwrite(u(k),0); % Actua sobre o processo
    Dt = toc; % Stop cronómetro
    pause(Ts-Dt) % Temporização    
    
    error(k) = y(k) - yd(k);
end
usbwrite(0,0)

subplot(2,1,1), plot(y(1:end)), hold on, plot(Ref)
title('Resposta do sistema em anel fechado')
ylabel('Saida'), xlabel('Amostra')
subplot(2,1,2), plot(u(1:end))
title('Atuacao')
ylabel('acao de controlo'), xlabel('Amostra')

somaErroQuadratico = error'*error;
mediaErroQuadratico = somaErroQuadratico / length(error);
save('Dados_Processo.mat')