function r = reflect( v, n )
%REFLECT Summary of this function goes here
%   Detailed explanation goes here
    r = 2*n*v'*n/(n*n') - v;
end

