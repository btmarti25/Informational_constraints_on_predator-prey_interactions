function [d_hE,maneuver] = get_maneuver(hE,init_hE,parms)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
maneuver=1;
dt=parms.dt;
maxturn=parms.E_maxturn;
end_angle=init_hE+parms.turn_angle;
angle_diff = abs(anglediff(end_angle, hE));


d_hE = sign(parms.turn_angle) * maxturn;

if angle_diff < dt* maxturn
d_hE = sign(parms.turn_angle) * angle_diff / dt;
maneuver = 2;
end

