function [P,m,K,Kf] = controller(A,B,C,S,Q,R,kfinal,r)
    
    P(:,:,kfinal+1)=C'*S*C;          % Matriz de covariancia
    m(:,:,kfinal+1)=C'*S*r(kfinal+1);% Vector de avanço
    
    % Offline computation of K e Kf
    % Optimal approach
    for k=kfinal:-1:1
        P(:,:,k)=A'*P(:,:,k+1)*(eye(size(A,1))-B*inv(B'*P(:,:,k+1)*B+R)*B'*P(:,:,k+1))*A+C'*Q*C;
        m(:,k)=(A'-A'*P(:,:,k+1)*B*inv(B'*P(:,:,k+1)*B+R)*B')*m(:,k+1)+C'*Q*r(k);
        K(:,:,k)=inv(B'*P(:,:,k+1)*B+R)*B'*P(:,:,k+1)*A;
        Kf(:,:,k)=inv(B'*P(:,:,k+1)*B+R)*B';
    end
end