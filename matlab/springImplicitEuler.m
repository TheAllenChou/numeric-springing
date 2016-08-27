function [ x2, v2 ] = springImplicitEuler( x1, v1, xt, zeta, omega, dt )

f = 1.0 + 2.0 * dt * zeta * omega;
omega2 = omega * omega;
detInv = 1.0 / (f + dt * dt * omega2);
detX = x1 * f + dt * v1 + dt * dt * omega2 * xt;
detV = v1 + dt * omega2 * xt - dt * omega2 * x1;

x2 = detX * detInv;
v2 = detV * detInv;

end

