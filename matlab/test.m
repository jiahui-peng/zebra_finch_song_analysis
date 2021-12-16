% ZEBRA FINCH SONG ANALYSIS

%% Import data
dir = '';
fname = 'Or154_44328.38135637_5_12_10_35_35.wav'; %OR154 d60
[y, Fss] = audioread(fname);


%% Visualization
[p,f,t] = pspectrum(y,Fss,'spectrogram', ...
                'TimeResolution', 2.5*10e-3,...
                'Leakage',0,...
                'MinThreshold',-80,...
                'FrequencyLimits',[400,25*10e3]);

plog=10*log10(p);

figure(1);
heatmap(t,f,plog,'GridVisible','off','Colormap',hot,...
        'XLabel','time / sec','YLabel','frequency / Hz');

       

%% Song detection

% Survey songs by the power ratio of 2-4kHz band versus all frequencies
% outside;
% Use a sliding window to calculate the above ratio along the time axis;

fthrs = 2000;
f_minidx = find(f>fthrs,1);
ptemp = max(plog,-1000);

for i=1:length(t)
    pMeanOverFmin(i) = mean(ptemp([f_minidx:length(f)],i));
end

figure(3)
plot(t,pMeanOverFmin)


%% Sliding window

tsize = 500;
tstep = 1;
pwindow =[];
for i=1:fix(length(t)/tstep)
    if i*tstep+tsize>length(t)
        break
    end
    pwindow(:,:,i) = plog(:,[1+(i-1)*tstep : 1+(i-1)*tstep+tsize]);
end

%%
heatmap(pwindow(:,:,2),'GridVisible','off','Colormap',hot,...
        'XLabel','time / sec','YLabel','frequency / Hz');
    

%% UMAP based on power-spectrum




