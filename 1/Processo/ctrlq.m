function [u] = ctrlq(B,F,G,P,Q,R,yk,yk1,yd)
    % COEF_u * u(k) = COEF_y * y(k) + COEF_r * r(k)
    COEF_u = conv(conv(P,B),F)+(R(1)/B(1))*R;
    COEF_y = -conv(P,G);
    COEF_yd = Q;
    
    atrasos_y = length(COEF_y);
    u = (COEF_y(1:atrasos_y)*[yk; yk1] + COEF_yd*yd)/ COEF_u(1);
end