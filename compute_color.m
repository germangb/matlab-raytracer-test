function pixel = compute_color( ray )
%COMPUTE_COLOR Summary of this function goes here
%   Detailed explanation goes here

    fog = [0.82, 0.935, 1];
    fog = [1, 1, 1];
    
    % camera transform
    ray(2) = ray(2)+1;
    ray(3) = 0.35;
    
    % materials
    mats = [1, 1, 1;1, 0.7, 0.4; 0.25, 0.96, 0.43; 0.325, 0.461, 1; 1, 1, 0];
    pixel = fog;
    
    % intersect plane
    [l, normal, mat] = scene_intersect(ray);
    if l > 0 && l < inf
       intersect = ray(1:3) + l * ray(4:6);
       
       pixel = mats(mat, :);
       %rnd = (rand(1, 3) * 2 - 1) * 0.025;
       %normal = normal + rnd;
       normal = normal / norm(normal);
       light = [-4, -0.25, 4.75];
       light = light / norm(light);
       am = -normal*light';
       
       if mat == 1
        am = 0.9;
       end
       
       % compute reflection
       if mat == 1
           rnd = (rand(1, 3) * 2 - 1);
           rnd(2) = 0;
           reflect_ray = [intersect + normal*0.0001, reflect(-ray(4:6), normal+rnd*0.05)];
           [lr, normal_re, mat_re] = scene_intersect(reflect_ray);
           if lr > 0 && lr < inf
               r_pos = reflect_ray(1:3) + lr * reflect_ray(4:6);
               r_cont = 1-exp(-norm(r_pos - intersect) * 2.0);
               
               r_am = max(-normal_re*light', 0.5);
               pixel = pixel * r_cont + mats(mat_re, :) * (1.0 - r_cont) * r_am;
           end
       end
       
       % compute shadow
       rnd = (rand(1, 3) * 2 - 1) * 0.1;
       rnd(2) = rnd(2) + 0.167;
       shadow_ray = [intersect + normal*0.0001, -light + rnd];
       ls = scene_intersect(shadow_ray);
       if ls > 0 && ls < inf
           am = -1;
       end
       
       % compute occlusion
       rnd = (rand(1, 3) * 2 - 1) * 0.35;
       ao_ray = [intersect + normal*0.0001, normal+rnd];
       [ls, ~, mat_occ] = scene_intersect(ao_ray);
       if mat_occ ~= mat && ls > 0 && ls < inf
           int_ao = ao_ray(1:3) + l * ao_ray(4:6);
           occl_dist = norm(int_ao - intersect);
           occl_cont = exp(-occl_dist*0.95);
           
           pixel = (1 - occl_cont) * pixel * 1.25 + occl_cont * mats(mat_occ, :) * 0.75;
           pixel = pixel * (1 * occl_cont + 0.5 * (1 - occl_cont));
       end
       
       pixel = pixel * max(am, 0.5);
       
       % fog
       t = exp(-norm(intersect) * 0.1);
       pixel = (1-t) * fog + t * pixel;
    end
end

