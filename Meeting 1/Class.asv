%% EX 1
% [y,Fs] = audioread('piano.wav');
% yReverse = flipud(y);
% soundsc(yReverse,Fs);
% plot(y);
% plot(yReverse);

%% EX 2
fs = 44100;

f1 = 100;
y1 = sin(2*pi*((1:2*fs)*f1/fs));

f2 = 1000;
y2 = sin(2*pi*((1:2*fs)*f2/fs));

ySum = y1+y2;

plot(y1);
 
%soundsc(y1,fs);
%pause
%soundsc(y2,fs);
%pause
%soundsc(ySum,fs);
%% 

%% EX 3

ALen = fs;
DLen = fs *0.25;
RLen = fs* 0.25;
SLen = 2*fs - (ALen + DLen + RLen);

ALevel = 1;
SLevel = 0.8;

A = linspace(0,ALevel,ALen);
D = linspace(ALevel,SLevel,DLen);
S = linspace(SLevel,SLevel,SLen);
R = linspace(SLevel,0,RLen);

ADSR = [A D S R];
% plot(ADSR);
result = ADSR .* y1;
plot(result);
soundsc(result, fs);



