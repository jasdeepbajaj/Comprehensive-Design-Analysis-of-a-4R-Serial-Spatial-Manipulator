clc
close all

L1 = 13;
L2 = 17;
L3 = 13;
L4 = 3;

Px = 16.2937;
Py = 9.4072;
Pz = 28.9748;
yaw = -60;
pitch = -80;
roll = -90;

p = [Px;Py;Pz];


R_Matrix = rot_z(yaw)*rot_y(pitch)*rot_x(roll);
T0_Wrist = [R_Matrix p;0 0 0 1];

%theta1
theta1_deg = atan2d(Py,Px);

%theta2
R = sqrt(Px^2+Py^2);
alpha = atan2d(Pz-L1,R);

A = sqrt((Pz-L1)^2+R^2);
beta = acosd((A^2 + L2^2 - L3^2)/(2*A*L2));

theta2_deg = alpha + beta;

%theta3
phi = acosd((L2^2 + L3^2 -A^2)/(2*L2*L3));
theta3_deg = phi - 90;


%theta4
T01 = dhparams2matrix([0 0 L1 theta1_deg]);
T12 = dhparams2matrix([0 90 0 theta2_deg]);
T23 = dhparams2matrix([L2 0 0 theta3_deg]);
T03 = T01*T12*T23;

T3_wrist = T03\T0_Wrist
theta4_deg = acosd(T34(1,1));

theta = [theta1_deg theta2_deg theta3_deg theta4_deg]


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

function T = dhparams2matrix(dhparams)
    a = dhparams(1);
    alpha = dhparams(2);
    d = dhparams(3);
    theta = dhparams(4);

    T = [cosd(theta), -sind(theta), 0, a;
        sind(theta)*cosd(alpha), cosd(theta)*cosd(alpha), -sind(alpha), -d*sind(alpha);
        sind(theta)*sind(alpha), cosd(theta)*sind(alpha), cosd(alpha), d*cosd(alpha);
        0, 0, 0, 1];
end
