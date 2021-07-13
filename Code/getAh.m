function [dAh] = getAh(A,Ah,E,t,parms)
% calculate turning rate of attacker based on proportional nav guidance law
lag=parms.pred_lag;
BA1 = getBA(A(t-lag-1,:),E(t-lag-1,:));
BA2 = getBA(A(t-lag,:),E(t-lag,:));
dBA=anglediff(BA1,BA2)/parms.dt;
dAh =  parms.Ak1 *  dBA  ;

if   abs(dAh) > parms.A_maxturn
    dAh=sign(dAh)*parms.A_maxturn;
end
end

