function [l, normal] = plane_intersect( ray, plane )
% coord [px, py, pz, rx, ry, rz]
% plane [A, B, C, D] Ax + By + Cz + D = 0

    % (x, y, z) = (px, py, pz) + l*(rx, ry, rz); 
    % Ax + By + Cz + D = 0
    % (px + l*rx)A + (py+l*ry)B + (pz+l*rz)C + D = 0
    % l = (-D - px*A - py*B - pz*C) / (rx*A + ry*B + rz*C)
    
    % compute intersection
    %l = (-plane(4) - plane(1)*ray(1) - plane(2)*ray(2) - plane(3)*ray(3)) / ...
    %    (plane(1)*ray(4) + plane(2)*ray(5) + plane(3)*ray(6));
    l = (-plane(4) - plane(1:3)*ray(1:3)') / (plane(1:3)*ray(4:6)');
    
    if l < 0
        l = inf;
    end
    
    normal = plane(1:3);
end

