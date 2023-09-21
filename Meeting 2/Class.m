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

%% FLANGER | CHORUS

delayBaseMs = 30; %ms
delayBase = round(delayBaseMs / 1000 * Fs);

freqLFO = 1; % Hz
lfo = sin(2*pi*((1:(length(x)+delayBase))*freqLFO/Fs));

flangerMaxDelayMs = 5; % ms
flangerMaxDepth = round(flangerMaxDelayMs / 1000 * Fs);

flangerOut = zeros(length(x) + delayBase, 2);
xPadded = [x;zeros(delayBase,2)];

circularBuffer = zeros(delayBase + flangerMaxDepth,2);
read = 1;
write = delayBaseMs;

for i = 1:length(flangerOut)
    lfoRead = round(lfo(i)*flangerMaxDepth);
    tmpRead = read + lfoRead;
    
    if tmpRead <= 0
        tmpRead = length(circularBuffer) + tmpRead;
    end
    if tmpRead > length(circularBuffer)
        tmpRead = tmpRead - length(circularBuffer);
    end

    flangerOut(i,1) = circularBuffer(tmpRead, 1);
    flangerOut(i,2) = circularBuffer(tmpRead, 2);

    circularBuffer(write, 1) = xPadded(i, 1);
    circularBuffer(write, 2) = xPadded(i, 2);

    write = write + 1;
    read = read + 1;

    if write > length(circularBuffer)
        write = 1;
    end
    if read > length(circularBuffer)
        read = read - length(circularBuffer);
    end
end

plot(flangerOut);


%% FUNCTIONS
function grain = createGrain(sound, window, grainSize)
    startTime = rand(1) * (length(sound)-grainSize);
    grain = sound(startTime:startTime + grainSize-1,:) .* window(grainSize); 
end