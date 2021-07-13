function [median_min_dist, q25, q75] = setup_simulation(parms,nreps)

for i = 1:nreps
    
    % get paramaters for simulation
    parms.Ak1=1+rand*2;
    parms.sE= parms.prey_speed_fact *10;%power law regime from NEE
    parms.A_length= exp(1.6+.6*randn);
    parms.sA=10 * exp(1.6+.6*randn);
    
    while  parms.sA <  parms.sE
        parms.A_length=exp(1.6+.6*randn);
        parms.sA=10*parms.A_length;
    end
    
    if parms.pred_rel_speed_option == 1
        parms.sA =  parms.sE * parms.pred_rel_speed;
    end
    
    parms.E_maxturn= parms.sE/(parms.minTurnRadii_prey);
    parms.A_maxturn= parms.sA/(parms.minTurnRadii_pred*parms.A_length);
    parms.pred_lag= round(parms.pred_delay/parms.dt,0);
    
    parms.prey_lag=round(parms.prey_delay/parms.dt);    
    % set initial conditions of simulation
    tint=0.55; % initital time to collision between attacker and evader (s)
    hE = parms.approach_angle;
    xA=tint*(parms.sE*cos(hE)-parms.sA); %initial x-position of attacker
    yA=tint*parms.sE*sin(hE); %initial y-position of attacker
    
    % run simulation 
    [mindist(i)]= run_simulation(xA,yA,hE,parms,tint);
end


median_min_dist=median(mindist)
s_mindist=sort(mindist);
q25=s_mindist(round(length(s_mindist)*.25));
q75=s_mindist(round(length(s_mindist)*.75));
end