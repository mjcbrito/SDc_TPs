clear all, clc,

A = [0.8706,-0.1122;0.5438,0.2508];
B = [0.0027;-0.0365];
C = [30.4787,-0.6672];

N = 150;
Ref = [3.0*ones(1,N), 4.0*ones(1,N), 3.0*ones(1,N), 2.5*ones(1,N), 3.5*ones(1,N)]'; % Definir o sinal de referência
kfinal = length(Ref) - 1;
Ts = 0.08;

u = zeros(length(Ref),1);
x = zeros(2,length(Ref),1);
y = zeros(length(Ref));
error = zeros(length(Ref),1);

usbinit

Pkk = 10 * eye(size(A)); % Covariancia inicial do erro do vetor de estado

S=50*eye(size(C,1)); % Penalização sobre o desvio final
Q=50*eye(size(C,1)); % Penalização sobre o desvio em relação à referência
R=0.5*eye(size(B,2)); %Penalização sobre a acção de controlo

[P,m,K,Kf] = controller(A,B,C,S,Q,R,kfinal,Ref);

disp('A controlar...')
for k = 1:kfinal
    y(k) = usbread(0);
    tic % inica cronometro
    
    if k <= 2
        u(k) = Ref(k);
    else
        u(k) = -K(:,:,k) * x(:,k) + Kf(:,:,k) * m(:,:,k+1);
    end
    
    u(k) = max(min(u(k),5),0);
    
    [x(:,k+1),Pkk] = kalman(A, B, C, u(k), y(k), x(:,k), Pkk);
    
    error(k) = y(k) - Ref(k);
    
    usbwrite(u(k),0);
    Dt = toc;
    pause(Ts - Dt);
end

usbwrite(0,0);

somaErroQuadratico = error'*error
mediaErroQuadratico = somaErroQuadratico / length(error)

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

save('dataset_optimo_processo.mat')