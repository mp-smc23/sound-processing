% [x,Fs] = audioread('piano.wav');
% d = Fs/2; % 0.5s

%% SINES
fs = 44100;
f1 = 50;
f2 = 500;
A1 = 1;
A2 = 1;
x1 = cos(2*pi*((1:2*fs)*f1/fs));
x2 = cos(2*pi*((1:2*fs)*f2/fs));

%% RING MODULATION
xRM = x1 .* x2;

subplot(3,1,1);
plot(x1);

subplot(3,1,2);
plot(x2);

subplot(3,1,3);
plot(xRM);

%% AMPLITUDE MODULATION

xAM = A1 * x2 .* x1 + A2 * x2;

subplot(3,1,1);
plot(x1);

subplot(3,1,2);
plot(x2);

subplot(3,1,3);
plot(xAM);

%% FREQUENCY MODULATION

fc = 200;
fm = 1000;
Afm = 1;
Ifm = 0.5;

xFM = Afm * sin(2*pi*((1:fs)*fc/fs) + Ifm * sin(2*pi*((1:fs)*fm/fs)) );

subplot(3,1,1);
plot(x1(1:fs/100));

subplot(3,1,2);
plot(x2(1:fs/100));

subplot(3,1,3);
plot(xFM(1:fs/100));

%% CHOWING

P3 = 1; % Length

P4 = 1000;   % A
P5 = 440;   % f[C]
P6 = 440;   % f[M]
P7 = 0;    % I[m1]
P8 = 5;    % I[m2]

t = (1:P3*fs);

modADSR = createADSR(fs, P3, (P8-P7)*P6);
modADSR = (P6*P7) + modADSR;
modulation = modADSR .* sin(t*2*pi*P6/fs);

y = sin(2 * pi * t * (P5/fs) + modulation);

ADSR = createADSR(fs, P3, P4);

output = ADSR .* y;
plot(output);


%% FUNCTIONS
function ADSR = createADSR(fs, soundLength, scale)
    ALen = fs * soundLength * 0.25;
    DLen = fs * soundLength * 0.25;
    RLen = fs * soundLength * 0.25;
    SLen = fs * soundLength - (ALen + DLen + RLen);
    
    ALevel = 1;
    SLevel = 0.8;
    
    A = linspace(0,ALevel,ALen);
    D = linspace(ALevel,SLevel,DLen);
    S = linspace(SLevel,SLevel,SLen);
    R = linspace(SLevel,0,RLen);
    
    ADSR = [A D S R] * scale;
end

function sine = createSin(f,t,fs)
    sine = sin(2*pi*((1:(t*fs))*f/fs));
end
