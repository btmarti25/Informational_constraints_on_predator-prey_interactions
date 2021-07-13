function [BA] = getBA(Focal_pos,Target_pos)
BA=atan2(Target_pos(2)-Focal_pos(2), Target_pos(1)-Focal_pos(1))   ;
end

