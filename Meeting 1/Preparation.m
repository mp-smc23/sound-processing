y1 = rand(44100,1);
y2 = rand(44100,1);
SR = 44100;
x = 1:SR;
stereoSound = [y1,y2];

normalizedStereo = stereoSound * 2;
normalizedStereo = normalizedStereo - 1;
normalizedStereo = normalizedStereo * 0.8;

% plot(x,stereoSound,'r',x, normalizedStereo,'b');

avg = mean(normalizedStereo);

stereoBack = normalizedStereo(SR-255:SR,:);

for x = 1:8
    stereoBack = [stereoBack; stereoBack];   
end

%soundsc(stereoBack, SR);

% SIN 441Hz
Hz = 441;
T = 44100/Hz;
sound = sin(2*pi*((0:T)/T));
soundLong = sound;

for i = 0:7
    soundLong = [soundLong soundLong];
end

plot(soundLong);
soundsc(soundLong,SR);

