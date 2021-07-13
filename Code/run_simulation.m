function [mindist ] = run_simulation(xA,yA,hE,parms,tint)
%run attack simulation
ploton=parms.ploton;

mindist=9999;
init_A=[xA,yA];
init_E=[0,0];
init_hA=0;
init_hE=hE;%+2*pi*rand;
lagsteps=(max(parms.prey_lag,parms.pred_lag)+2);
out_A(1:lagsteps,:)=repelem(init_A,lagsteps,1);
out_E(1:lagsteps,:)=repelem(init_E,lagsteps,1);
out_hA(1:lagsteps,:)=repelem(init_hA,lagsteps,1);
out_hE(1:lagsteps,:)=repelem(init_hE,lagsteps,1);

A=out_A(lagsteps,:);
E=out_E(lagsteps,:);
hE=out_hE(lagsteps,:);
hA=out_hA(lagsteps,:);
if ploton == 1
    plot(out_A(:,1),out_A(:,2),'r')
    xlim([-5 5])
    ylim([-5 5])
end
maneuver=0;
tau_c=parms.tau_c;

Inttime = round(5* tint /parms.dt)+lagsteps;
for t=lagsteps:Inttime
    d_hA=  getAh(out_A,hA,out_E,t,parms);
    tau=get_tau(out_A,out_E,t,parms);
    d_hE =0;
    if tau < tau_c && maneuver == 0
        maneuver = 1;
    end
    if maneuver == 1
        [d_hE,maneuver] = get_maneuver(hE,init_hE,parms);
    end
    
    y0 = [hA,hE,A,E];
    [tt,y] = integrate_movement(parms,0,parms.dt,y0,d_hA,d_hE);
    
    hA=y(length(y),1);
    hE=y(length(y),2);
    A= y(length(y),3:4);
    E= y(length(y),5:6);
    
    t_mindist=  min(sqrt((y(:,3)-y(:,5)).^2+(y(:,4)-y(:,6)).^2)) ;
    
    mindist=min(mindist,t_mindist);
    
    
    out_A(t+1,:)=A;
    out_E(t+1,:)=E;
    if ploton == 1 & (mod(t,2)==0) & t > .2 * Inttime
        hold on
        plot(out_E(:,1),out_E(:,2),'b')
        plot(out_A(:,1),out_A(:,2),'r')
        plot(out_A(:,1),out_A(:,2),'r')
        xlim([-15,15])
        ylim([-15,15])
        pause(.00001)
    end
    if sqrt((A(1)-E(1))^2+(A(2)-E(2))^2) > 2*mindist
        break
    end
    if ploton == 1
        hold off
    end
    
    
    
end

