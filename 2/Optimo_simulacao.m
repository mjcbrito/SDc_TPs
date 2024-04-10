clear all, clc,
load('ss2.mat');

A = ss2.A;
B = ss2.B;
C = ss2.C;

N = 150;
Ref = [3.0*ones(1,N), 4.0*ones(1,N), 3.0*ones(1,N), 2.5*ones(1,N), 3.5*ones(1,N)]'; % Definir o sinal de referência
kfinal = length(Ref) - 1;
Ts = 0.08;

u = zeros(length(Ref))
x = zeros(2,length(Ref));
y = zeros(length(Ref));
error = zeros(length(Ref));

usbinit

Pkk = 10 * eye(size(A)); % Covariancia inicial do erro do vetor de estado

S=50*eye(size(C,1)); % Penalização sobre o desvio final
Q=50*eye(size(C,1)); % Penalização sobre o desvio em relação à referência
R=0.5*eye(size(B,2)); %Penalização sobre a acção de controlo

[P,m,K,Kf] = controller(A,B,C,S,Q,R,kfinal,Ref);

disp('A controlar...')
for k = 1:kfinal
    y(k,1) = usbread(0);
    tic % inica cronometro
    
    if k <= 2
        u(k,1) = Ref(k);
    else
        u(k,1) = -K(:,:,k) * x(:,k) + Kf(:,:,k) * m(:,:,k+1);
    end
    
    u(k,1) = max(min(u(k),5),0);
    
    [x(:,k+1),Pkk] = kalman(A, B, C, u(k,1), y(k,1), x(:,k), Pkk);
    
    error(k) = y(k) - Ref(k);
    
    usbwrite(u(k),0);
    Dt = toc;
    pause(Ts - Dt);
end

usbwrite(0,0);

somaErroQuadratico = error'*error;
mediaErroQuadratico = somaErroQuadratico / length(error);