function [ ] = springTest( f, zeta, omega, duration )

dt = 1 / 60;
tv = 0:dt:duration;

t = zeros(1, length(tv));
y = zeros(1, length(tv));
x = 1;
v = 0;
xt = 0;

for i = 1:length(tv)
    t(i) = i * dt;
    y(i) = x;
    [x, v] = f(x, v, xt, zeta, omega, dt);
end

set(figure(), 'Position', [200, 200, 400, 250]);
plot(t, y);
xlabel('time');
ylabel('value');
axis([0, duration, -1, 1]);

end

