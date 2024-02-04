clc
clear

syms L1 L2 L3 L4 theta1 theta2 theta3 theta4

DH_table = [0 0 L1 theta1; 
            0 pi/2 0 theta2; 
            L2 0 0 theta3; 
            0 pi/2 L3 theta4];

% Define transformation matrices from frame i-1 to i
T01 = simplify(dhparams2matrix(DH_table(1,:)));
T12 = simplify(dhparams2matrix(DH_table(2,:)));
T23 = simplify(dhparams2matrix(DH_table(3,:)));
T34 = simplify(dhparams2matrix(DH_table(4,:)));


T04 = simplify(T01*T12*T23*T34);

T04 = subs(T04, cos(theta1), 'c1');
T04 = subs(T04, sin(theta1), 's1');
T04 = subs(T04, cos(theta2), 'c2');
T04 = subs(T04, sin(theta2), 's2');
T04 = subs(T04, cos(theta3), 'c3');
T04 = subs(T04, sin(theta3), 's3');
T04 = subs(T04, cos(theta4), 'c4');
T04 = subs(T04, sin(theta4), 's4');
T04 = subs(T04, cos(theta2 + theta1), 'c12');
T04 = subs(T04, sin(theta2 + theta1), 's12');
T04 = subs(T04, sin(theta2 + theta3), 's23');
T04 = subs(T04, cos(theta2 + theta1), 'c12');
T04 = subs(T04, sin(theta2 + theta1), 's12');
T04 = subs(T04, cos(theta2 + theta3), 'c23');
T04 = subs(T04, sin(theta2 + theta1), 's12');

T04

function T = dhparams2matrix(dhparams)
    a = dhparams(1);
    alpha = dhparams(2);
    d = dhparams(3);
    theta = dhparams(4);

    T = [cos(theta), -sin(theta), 0, a;
        sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha), -d*sin(alpha);
        sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha), d*cos(alpha);
        0, 0, 0, 1];
end