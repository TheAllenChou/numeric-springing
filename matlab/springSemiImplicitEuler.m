function [ x2, v2 ] = springSemiImplicitEuler( x1, v1, xt, zeta, omega, dt )

v2 = v1 - 2.0 * dt * zeta * omega * v1 - dt * omega * omega * (x1 - xt);
x2 = x1 + dt * v2;

end

