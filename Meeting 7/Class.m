%% SCHROEDER no 1
g = 0.707;
M0 = 227;
M1 = 387;
M2 = 677;

a0 = [1; zeros(M0-1,1);  g];
b0 = [g; zeros(M0-1,1); -1];

a1 = [1; zeros(M1-1,1);  g];
b1 = [g; zeros(M1-1,1); -1];

a2 = [1; zeros(M2-1,1); g];
b2 = [g; zeros(M2-1,1); -1];

SR = 44100;
s = sin((1:100)).';
x = [s; zeros(SR,1)];

[y, zf] = filter(b0, a0, x);
[y, zf] = filter(b1, a1, y);
[y, zf] = filter(b2, a2, y);

subplot(3,1,1);
plot(x);
subplot(3,1,2);
plot(y);

%% SCHROEDER no 2
b0_comb = 0.2;
a0_comb = 0.5;
L0 = 137;
L1 = 253;
L2 = 517;
L3 = 623;

[y0, ~] = filter([b0_comb], [1; zeros(L0-1,1); a0_comb], x);
[y1, ~] = filter([b0_comb], [1; zeros(L1-1,1); a0_comb], x);
[y2, ~] = filter([b0_comb], [1; zeros(L2-1,1); a0_comb], x);
[y3, ~] = filter([b0_comb], [1; zeros(L3-1,1); a0_comb], x);

ySum = y0 + y1 + y2 + y3;

[y, zf] = filter(b0, a0, ySum);
[y, zf] = filter(b1, a1, y);

subplot(3,1,1);
plot(x);
subplot(3,1,2);
plot(ySum);
subplot(3,1,3);
plot(y);

%% reverb lol

fs = 44100;
f1 = 50;
x = cos(2*pi*((1:0.5*fs)*f1/fs)).';

b0_comb = 0.2;
a0_comb = 0.5;
g=0.7;

% s = sin((1:100)).';
x = [x; zeros(SR,1)];

a0 = [1; zeros(1051-1,1);  g];
b0 = [g; zeros(1051-1,1); -1];

a1 = [1; zeros(337-1,1);  g];
b1 = [g; zeros(337-1,1); -1];

a2 = [1; zeros(113-1,1); g];
b2 = [g; zeros(113-1,1); -1];

[y, zf] = filter(b0, a0, x);
[y, zf] = filter(b1, a1, y);
[y, zf] = filter(b2, a2, y);

[y0, ~] = filter([1; zeros(4799-1,1); 0.742], [1], y);
[y1, ~] = filter([1; zeros(4999-1,1); 0.733], [1], y);
[y2, ~] = filter([1; zeros(5399-1,1); 0.715], [1], y);
[y3, ~] = filter([1; zeros(5801-1,1); 0.697], [1], y);

y = y0 + y1 + y2 + y3;

subplot(2,1,1);
plot(x);
subplot(2,1,2);
plot(y);

