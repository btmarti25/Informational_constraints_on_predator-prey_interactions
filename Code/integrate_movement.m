
function [tt,y] = integrate_movement(parms, tBegin,tEnd,y0,d_hA,d_hE)

[tt,y] = ode45(@derivatives, [tBegin tEnd], y0);

    function dydt = derivatives(tt,y)
        dydt = zeros(4,1);
        dydt(1) = d_hA;
        dydt(2) = d_hE;
        dydt(3) = parms.sA*cos(y(1));
        dydt(4) = parms.sA*sin(y(1));
        dydt(5) = parms.sE*cos(y(2));
        dydt(6) = parms.sE*sin(y(2));
    end
end