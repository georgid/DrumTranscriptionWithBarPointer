
% wavpath = fullfile('/Users', 'joro', 'Documents', 'Linz',...
% 	'RHYTHMIC_14March', 'ENST-drums-extracted',...
% 	'accompaniment_all_drummers');




function mixDrumAndAccompaniment(wavpath, wav )



propGainDecrease1 = 1/3;
propGainDecrease2 = 2/3;

wav1 = [wav '.wav'];
wav2 = [wav '_acc.wav'];

[x1, Fs] = wavread(fullfile(wavpath, wav1));
x2 = wavread(fullfile(wavpath, wav2));

% plot(y1(1:10*44100))
% figure
% plot(y2(1:10*44100))

n1 = size(x1, 1);
n2 = size(x2, 1);
nmax = max(n1, n2);

y1 = zeros(nmax, 1);
y2 = zeros(nmax, 1);
y1(1:n1) = propGainDecrease1*x1;
y2(1:n2) = propGainDecrease2*x2;

% z = y1 + y2;
w = [y1 y2];

wavwrite(w, Fs, fullfile(wavpath, wav1));

end