function [l, normal] = sphere_intersect( ray, radius )
%SPHERE_INTERSECT Summary of this function goes here
%   Detailed explanation goes here

%   float sphere (vec3 o, vec3 d) {
%       // <xyz,xyz> = R^2
%       float disc = 4.0*dot(d,o)*dot(d,o)-4.0*dot(d,d)*(dot(o,o)-RADIUS*RADIUS);
%       if (disc < 0.0) return INF;
%       return (-2.0*dot(d,o)-sqrt(disc))/(2.0*dot(d,d));
%   }

    % compute discriminant
    dot_ori_dir = ray(1:3)*ray(4:6)';
    dot_ori_ori = ray(1:3)*ray(1:3)';
    dot_dir_dir = ray(4:6)*ray(4:6)';
    disc = 4*dot_ori_dir*dot_ori_dir - 4*dot_dir_dir*(dot_ori_ori-radius*radius);
    
    if disc < 0
        l = inf;
        normal = [0, 0, 0];
    else
        l = (-2 * dot_ori_dir - sqrt(disc)) / (2*dot_dir_dir);
        normal = ray(1:3) + l*ray(4:6);
    end

end

