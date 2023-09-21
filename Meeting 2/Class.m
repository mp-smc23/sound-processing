[x,Fs] = audioread('piano.wav');
d = Fs/2; % 0.5s

% SINE
%f = 5;
%x = sin(2*pi*((1:2*fs)*f/fs));
% plot(x);

%% DELAY
delay = zeros(d,2);
y = [delay; x];

plot(y)
hold on;
plot(x)

%% ECHO
delay2 = zeros(d,2);
yEcho = [delay2; x];
attenuation = 0.25;

y2 = [x; delay2] + yEcho * attenuation;
soundsc(y,Fs);
plot(y2);

%% GRAIN SYNTH

grainSizeMs = 50;                       % ms
grainSize = grainSizeMs / 1000 * Fs;    % length of grain in samples
grainDensity = 50;                      % grains per second

synthSizeS = 2;                         % length of output in seconds
synthSize = synthSizeS * Fs;            % length of output in samples
synth = zeros(synthSize, 2);            % output


for i = 1:(50*synthSizeS)
    grain = createGrain(x, @hann, grainSize); % create a grain of given size
    startTime = randi(synthSize-grainSize); % time the grain starts (random, asynch)
    timeAfterGrain = synthSize - startTime - grainSize; % for array concat, after grain time
    grainConcatZero = [zeros(startTime,2); grain; zeros(timeAfterGrain,2)];
    synth = synth + grainConcatZero;
end
    
% plot(synth);
soundsc(synth,Fs);



%% FUNCTIONS
function grain = createGrain(sound, window, grainSize)
    startTime = rand(1) * (length(sound)-grainSize);
    grain = sound(startTime:startTime + grainSize-1,:) .* window(grainSize); 
end