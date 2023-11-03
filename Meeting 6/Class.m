%% DEFINE FILTER
a = [1,0,0,0,0,0,0,0,0,0,1];
b = [1,0,0,-5,0,0,0,0,0.3,0,0];
SR = 44100;
x = rand(SR, 1);

[y, zf] = filter(b,a,x);

%% FV TOOL PLOT
fvtool(b,a);
% fvtool(zf);

%% PLOT AND SPECTOGRAM
subplot(2,1,1);
plot(y);

subplot(2,1,2);
plot(x);
%spectogram(x);
%% ZPLANE
zplane(b,a);