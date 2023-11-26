%% CONSTS
SR = 44100;
BurstLen = SR / 100;
ZerosLen = 5 * SR;
Len = ZerosLen + BurstLen;
L = 100;

%% GENERATE INPUT SIGNAL
x = rand(BurstLen, 1) * 2 - 1 ;
x = [x; zeros(ZerosLen,1)];

% plot(x);

%% SIMPLE KS 
y = zeros(Len, 1);

% y[n] = x[n] + 0.5y[n − L] + 0.5y[n − (L + 1)]
for n = 1:Len
    y(n) = x(n); % + x[n]
    if n - L > 0
        y(n) = y(n) + 0.5 * y(n-L); %  + 0.5y[n − L]
    end
    if n - (L+1) > 0
        y(n) = y(n) + 0.5 * y(n-L-1); % + 0.5y[n − (L + 1)] 
    end
end

plot(y);

%% FRACTIONAL DELAY

y1 = zeros(Len, 1);
delay = 100.227;
fracL = delay - fix(delay);
intL = fix(delay);


% y[n] = x[n] + 0.5y[n − L] + 0.5y[n − (L + 1)]
for n = 1:Len
    y1(n) = x(n); % + x[n]
    if n - L > 0
        y1(n) = y1(n) + 0.5 * fracDelay(y1, n - intL, fracL); %  + 0.5y[n − L]
    end
    if n - (L+1) > 0
        y1(n) = y1(n) + 0.5 * fracDelay(y1, n - intL - 1, fracL); % + 0.5y[n − (L + 1)] 
    end
end

plot(y1);
    
%% ALL PASS 
% y[n] = g * x[n] - x[n-1] - g * y[n-1]
f1 = 440;
L = floor(SR/f1);
Lfrac = SR/f1 - floor(SR/f1);
C = (1 - Lfrac)/(1 + Lfrac); % fraction of frequency

b = [zeros(L,1); 1; C];
a = [1; C; zeros(L-2,1); 0.5*C; 0.5*(1+C); 0.5]; % f.. matlab with - and + signs

[y, zf] = filter(b, a, x);

plot(y);

%% PLOTING

subplot(3,1,1);
plot(y);
subplot(3,1,2);
plot(y1);
subplot(3,1,3);
plot(y1-y);


%% functions

function x = fracDelay(y, i, frac)
    x = (1 - frac) * y(i) + frac * y(i+1);
end