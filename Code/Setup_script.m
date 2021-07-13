clear all

n_reps = 1000 ; %number of replicate simulations per parm combination

% specify parameter combinations to simulate

parms.ploton = 0;
parms.tau_c =exp(-4:.3:0); % tau_c for evasion maneuver
parms.turn_angle= (0:30:180)/57; % turn angle, alpha of evasive maneuver
parms.pred_delay= 0.0;%[.025,.05,.1]; % delta_A, attacker sensory-motor delay
parms.prey_delay= 0; % delta_E, evader sensory-motor delay
parms.approach_angle=[0]; % approach angle
parms.prey_speed_fact = [1];%[.7 .8 .9 1 1.1 1.2 1.3];
parms.minTurnRadii_prey=0.15;
parms.minTurnRadii_pred=0.15;
parms.dt=1/100;
parms.pred_rel_speed_option =0; % set to 1 to have predator speed set to fixed fraction of prey speed (pred_rel_speed)
if parms.pred_rel_speed_option == 1
    parms.pred_rel_speed = [1.5 2.5 3.5];   
end

facID=0;
fn = fieldnames(parms);

for k=1:numel(fn)
    if( isnumeric(parms.(fn{k})) )
        facID=facID+1;
        fac1{facID}= parms.(fn{k});
    end
end

% generate table of factorial combinations parms to simulate (parmset)

parmset=[]
elements = {fac1{:}};
combinations = cell(1, numel(elements));
[combinations{:}] = ndgrid(elements{:});
combinations = cellfun(@(x) x(:), combinations,'uniformoutput',false);
parmset = [combinations{:}];

% run through parameter combinations
for i = 1:size(parmset,1)
    i
    tempparms=parms;
    for k=1:numel(fn)
        if( isnumeric(parms.(fn{k})) )
            facID=facID+1;
            tempparms.(fn{k})=parmset(i,k);
            
        end
    end
    
    [median_miss_dist(i), q25(i), q75(i)]=setup_simulation(tempparms,n_reps);
end
T = array2table(parmset,...
    'VariableNames',cellstr(fn))

T.mean_miss_dist=median_miss_dist';
T.q25_dist=q25';
T.q75_dist=q75';
writetable(T,"filename.csv")
