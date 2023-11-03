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

%% ALL PASS
