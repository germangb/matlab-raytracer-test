function [l, normal, mat] = scene_intersect( ray )
%SCENE_INTERSECT Summary of this function goes here
%   Detailed explanation goes here

    % intersect plane
    [l, normal] = plane_intersect(ray, [0, 1, 0, 0]);
    mat = 1;
    
    % intersect sphere
    ps = [0, 0, 4; -1.5, -0.25, 2.5; 1.15, 0.35, 1.75; -4, 0, 16];
    rs = [2, 1, 0.5, 10];
    for i = 1:4
        [l0, normal0] = sphere_intersect(ray - [ps(i, :), 0, 0, 0], rs(i));
        if l0 < l && l0 > 0 && l0 < inf           
           l = l0;
           normal = normal0;
           mat = i+1;
        end
    end

end

