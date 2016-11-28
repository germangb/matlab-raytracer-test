distcomp.feature('LocalUseMpiexec', false);
clear all
close all

s = [512, 512];
aspect = s(2) / s(1);

I = zeros(prod(s), 3);
O = zeros([s, 3]);
F = O;
N = 16;

for pass=1:N
    disp(pass)
    tic
    parfor i=1:s(2)*s(1)
        x = floor((i-1) / s(1));
        y = floor(mod(i-1, s(1)));

        norm = [x, y] ./ [s(2), s(1)] * 2 - 1;
        norm = norm .* [aspect, -1]; 

        ray = [norm, 0, norm, 1];
        I(i, :) = compute_color(ray);
    end
    toc
    
    O(:,:,1) = reshape(I(:, 1), s);
    O(:,:,2) = reshape(I(:, 2), s);
    O(:,:,3) = reshape(I(:, 3), s);
    
    %if pass == 1
    %    F = O;
    %end
    
    F = F + O;
    imshow(imresize(F/pass, 0.5));
    %title(sprintf('#%d iteration', pass));
    %waitforbuttonpress
end

%% img
imshow(imresize(F/N, 0.5));