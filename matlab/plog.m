% compute and output the log scale of power in fft of the songs

%% Import data
% datadir = '/Users/jiahuipeng/OneDrive - California Institute of Technology/hpc/songanalysis/data';
% flist = dir([datadir,'/Or154/44/song/*.wav']);

fname = 'Or154_44328.59178154_5_12_16_26_18.wav';
[y, Fss] = audioread(fname);

%% Compute fft and output
[p,f,t] = pspectrum(y,Fss,'spectrogram', ...
                'TimeResolution', 2.5*10e-3,...
                'Leakage',0,...
                'MinThreshold',-80,...
                'FrequencyLimits',[400,25*10e3]);

plog_mt=10*log10(p);

%% Visualization
figure(1);
heatmap(t,f,plog,'GridVisible','off','Colormap',hot,...
        'XLabel','time / sec','YLabel','frequency / Hz');

% Save into a long mat
save('plog.mat',['plog', int2str(i)],'-append')

