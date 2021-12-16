% ZEBRA FINCH SONG ANALYSIS

%% Import data
fname = 'Or154_44328.59284103_5_12_16_28_4.wav'; %OR154 d60
[y, Fss] = audioread(fname);

[y, Fss] = audioread('/Users/jiahuipeng/Desktop/Or154_44328.59178154_5_12_16_26_18.wav')
%% Visualization
[p,f,t] = pspectrum(y,Fss,'spectrogram', ...
                'TimeResolution', 2.5*10e-3,...
                'Leakage',0,...
                'MinThreshold',-80,...
                'FrequencyLimits',[400,25*10e3]);
colormap(hot)
            
%% Song detection

% Survey songs by the power ratio of 2-4kHz band versus all frequencies
% outside;
% Use a sliding window to calculate the above ratio along the time axis;

f_thrmax = 6000; % Hz, threshold max
f_thrmin = 2000;

t_window = 0.01;
t_slide = 0.01;


deltat = t(2)-t(1); %sec, sampling rate, interval of t vector
l_window = round( t_window/deltat ); % length of window
l_slide = round ( t_slide/deltat ); %length of sliding step
n = round( (length(t) - l_window)/l_slide ); % number of window

fbi = f<f_thrmax & f>f_thrmin;
f_minidx = find(fbi,1);
f_maxidx = find(fbi,1,'last');

ppstn = []; % power% in each window
tn = [];% start time of each window
psum = []; % sum of all power

pnorm = p-min(p);
pnorm = pnorm/mean(mean(pnorm));

for i=1:n
    tn(i) = deltat*l_slide*(i-1);
    
    ppstn(i) = sum( pnorm([f_minidx:f_maxidx],[i:i+l_window]) )...
               /sum( pnorm([1:f_minidx-1,f_maxidx+1:length(f)],[[i:i+l_window]]) );
    
    psum(i) = sum(sum (( p(:,[i:i+l_window]) )) );
end
figure(2)
plot(tn,ppstn)

figure(3)
plot(tn,psum)





            