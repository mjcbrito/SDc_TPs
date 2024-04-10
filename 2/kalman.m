function [x_corrigido P_corrigido] = kalman(A, B, C, u_anterior, y_k, x_anterior, P_anterior)
    
    W = ((1/lambda) - 1) * P_anterior;
    V = 0.14; % Variância do modelo
    lambda = 0.98; % Factor de esquecimento (ver nas páginas de CI)
    
    % Estimacao
    x_estimado = A*x_anterior + B*u_anterior;
    P_estimado = A*P_anterior*A' + W;
    
    % Correccao
    K = P_estimado * C' * (C*P_estimado*C' + V)^-1;
    x_corrigido = x_estimado + K * (y_k - C*x_estimado);
    P_corrigido = (eye(size(K*C)) - K*C) * P_estimado;
    
end