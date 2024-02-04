clc
clear
close all

syms L1 L2 L3 L4 theta1 theta2 theta3 theta4

%screw-axis1
w_s1 = [0;0;1];
q_1 = [0;0;0];
v_s1 = -cross(w_s1,q_1);

%screw-axis2
w_s2 = [sind(theta1);-cosd(theta1);0];
q_2 = [0;0;L1];
v_s2 = -cross(w_s2,q_2);

%screw-axis3
w_s3_home = [0;-1;0];  %in home configuration
w_s3 = rot_z(theta1)*rot_y(-theta2)*w_s3_home;
q_3 = q_2 + rot_z(theta1)*rot_y(-theta2)*[L2;0;0];
v_s3 = -cross(w_s3,q_3);

%screw-axis4
w_s4_home = [0;0;-1];  %in home configuration
w_s4 = rot_z(theta1)*rot_y(-theta2)*rot_y(-theta3)*w_s4_home;
q_4 = q_3 + rot_z(theta1)*rot_y(-theta2)*rot_y(-theta3)*[0;0;-L3];
v_s4 = -cross(w_s4,q_4);

Jacob = [w_s1 w_s2 w_s3 w_s4; v_s1 v_s2 v_s3 v_s4]


function [R_z] = rot_z(theta)

R_z = [cosd(theta) -sind(theta) 0;
    sind(theta) cosd(theta) 0;
    0 0 1];
end

function [R_y] = rot_y(theta)

R_y = [cosd(theta) 0 sind(theta);
    0 1 0;
    -sind(theta) 0 cosd(theta)];
end

function [R_x] =  rot_x(theta)

R_x = [1,0,0;
       0,cosd(theta),-sind(theta);
       0,sind(theta),cosd(theta)];

end
