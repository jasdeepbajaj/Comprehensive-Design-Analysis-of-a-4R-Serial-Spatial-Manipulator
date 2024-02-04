L1 = 13;
L2 = 17;
L3 = 13;
L4 = 3;
theta1 = 30;
theta2 = 70;
theta3 = 20;
theta4 = 10;

DH_table = [0 0 L1 theta1; 
            0 90 0 theta2; 
            L2 0 0 theta3; 
            0 90 L3 theta4];

T01 = (dhparams2matrix(DH_table(1,:)));
T12 = (dhparams2matrix(DH_table(2,:)));
T23 = (dhparams2matrix(DH_table(3,:)));
T34 = (dhparams2matrix(DH_table(4,:)));

T04 = T01*T12*T23*T34;
p_wrist = T04(1:3,4);

R04 = T04(1:3,1:3);
yaw = atan2d(R04(2,1), R04(1,1));
pitch = asind(-R04(3,1));
roll = atan2d(R04(3,2), R04(3,3));
o_wrist = [yaw;pitch;roll];

p_o_wrist = [p_wrist; o_wrist]



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