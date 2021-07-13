function [tau] = get_tau(A,E,t,parms)
% Estimate time to predator collision
%   Detailed explanation goes here
sizeA=.1*parms.A_length;
lag=parms.prey_lag;
dt=parms.dt;
distA1=sqrt((A(t-lag-1,1)-E(t-lag-1,1))^2+(A(t-lag-1,2)-E(t-lag-1,2))^2);
distA2=sqrt((A(t-lag,1)-E(t-lag,1))^2+(A(t-lag,2)-E(t-lag,2))^2);
thetaA1= atan(sizeA/distA1);
thetaA2= atan(sizeA/distA2);
if thetaA2-thetaA1 > 0
    tau=thetaA1/((thetaA2-thetaA1)/dt);
else
    tau=100;
end
end

