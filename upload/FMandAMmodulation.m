%

clc
clear all
close all



%% Parameters 

samplingFrequency = 8000;
carrierFrequency = 1500;
bitResolution = 8;
recordTime = 5;
channel = 2;
carrierAmplitude = 0;
carrierAmplitudeDemod = 0;
initialPhaseForModulation = 0;

frequencyDeviation = 150;

%% Files names for AM and FM modulation 

beforeTransmissionFile = 'AudioFiles/New/recordedSound.wav';
receviedAmSoundFile = 'AudioFiles/New/receivedAMVoice.wav';
receviedFmSoundFile = 'AudioFiles/New/receivedFMVoice.wav';



%%
%% Finds and store the device used for recording

selectInputDeviceID = inputDeviceInformation();


%% Sets up the parameters of audio recorder in matlab and 

%%Records the sound for time interval specified

disp('Alright! say "This is ECEN-649. My name is Asim. I am doing an assigned project."')
recordedSound = audioRecorder(samplingFrequency,bitResolution,channel,selectInputDeviceID,recordTime);
disp('Its done! you can stop now :)')


%% Write the original audio file in assigned format before

audiowrite(beforeTransmissionFile,recordedSound,samplingFrequency);

%% Calculate the spectrum of recorded sound

lengthOfSignal = length(recordedSound);
spectrum = fft(recordedSound);
normalizedSpectrum= abs(spectrum/lengthOfSignal);
frequencySpectrum= normalizedSpectrum(1:lengthOfSignal/2+1);
frequencySpectrum(2:end-1) = 2*frequencySpectrum(2:end-1);
frequencyAxis= samplingFrequency*(0:(lengthOfSignal/2))/lengthOfSignal;

%% AM modulation of the recorded signal 

modulatedAmSignal = ammod(recordedSound,carrierFrequency,samplingFrequency,initialPhaseForModulation,carrierAmplitude);

%% Spectrum of modulated signal

spectrumAM = fft(modulatedAmSignal);
normalizedSpectrumAm= abs(spectrumAM/lengthOfSignal);
frequencySpectrumAm= normalizedSpectrumAm(1:lengthOfSignal/2+1);
frequencySpectrumAm(2:end-1) = 2*frequencySpectrumAm(2:end-1);


%% AM demodulation of the modulated signal

[num,den] = butter(10,carrierFrequency*2/samplingFrequency);

demodulatedAmSignal  = amdemod(modulatedAmSignal,carrierFrequency,samplingFrequency,initialPhaseForModulation,carrierAmplitudeDemod,num,den);

demodulatedAmsignalNorm = demodulatedAmSignal./(max(abs(demodulatedAmSignal)));
%% Spectrum of demodulated signal

spectrumAMDemodulation = fft(demodulatedAmsignalNorm);
normalizedSpectrumAmDemodulation= abs(spectrumAMDemodulation/lengthOfSignal);
frequencySpectrumAmDemodulation= normalizedSpectrumAmDemodulation(1:lengthOfSignal/2+1);
frequencySpectrumAmDemodulation(2:end-1) = 2*frequencySpectrumAmDemodulation(2:end-1);


%% Writing the demodulated signal into file

audiowrite(receviedAmSoundFile,demodulatedAmsignalNorm,samplingFrequency);



%% FM modulation of the recorded signal

modulatedFmSignal = fmmod(recordedSound,carrierFrequency,samplingFrequency,frequencyDeviation);

%% Spectrum of FM modulation

spectrumFM = fft(modulatedFmSignal);
normalizedSpectrumFm= abs(spectrumFM/lengthOfSignal);
frequencySpectrumFm= normalizedSpectrumFm(1:lengthOfSignal/2+1);
frequencySpectrumFm(2:end-1) = 2*frequencySpectrumFm(2:end-1);


%% FM demodulation of the modulated signal 

demodulatedFmsignal = fmdemod(modulatedFmSignal,carrierFrequency,samplingFrequency,frequencyDeviation);
demodulatedFmsignalNorm = demodulatedFmsignal./(max(abs(demodulatedFmsignal)));

%% Spectrum of demodulated signal 
spectrumFMDemodulation = fft(demodulatedFmsignalNorm);
normalizedSpectrumFMdemodulation= abs(spectrumFMDemodulation/lengthOfSignal);
frequencySpectrumFmDemodulation= normalizedSpectrumFMdemodulation(1:lengthOfSignal/2+1);
frequencySpectrumFmDemodulation(2:end-1) = 2*frequencySpectrumFmDemodulation(2:end-1);



audiowrite(receviedFmSoundFile,demodulatedFmsignalNorm,samplingFrequency);


%% Plot the orginal and received signal/sound

% Original signal
figure('Name','Time Domain Plots');
originalSignal = subplot(5,1,1);
plot(originalSignal,recordedSound);
title('Original Voice Signal')
xlabel('Time');
ylabel('Amplitude');
% AM modulated signal

modulatedAm = subplot(5,1,2);
plot(modulatedAm, modulatedAmSignal);
title('AM Modulated Signal')
xlabel('Time');
ylabel('Amplitude');

% Received demodulated am signal signal

demodulatedAm = subplot(5,1,3);
plot(demodulatedAm, demodulatedAmSignal);
title('AM Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');

% FM modulated signal 

modulatedFm = subplot(5,1,4);
plot(modulatedFm, modulatedFmSignal);
title('FM Modulated Signal');
xlabel('Time');
ylabel('Amplitude');

% FM demodulated signal

demodulatedFm = subplot(5,1,5);
plot(demodulatedFm, demodulatedFmsignalNorm);
title('FM Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');

%% Spectrum Plots

% Original signal

figure('Name','Frequency Spectrum');
freuquencySpectrum = subplot(5,1,1);
plot(freuquencySpectrum,frequencyAxis,frequencySpectrum)
title('Original Signal Spectrum');
xlabel('Frequency');
ylabel('Amplitude'); 

%AM modulation spectrum

freuquencySpectrumAm = subplot(5,1,2);
plot(freuquencySpectrumAm,frequencyAxis,frequencySpectrumAm)
title('AM Modulated Spectrum');
xlabel('Frequency');
ylabel('Amplitude');
 
% AM demodulation spectrum

freuquencySpectrumAmDemo = subplot(5,1,3);
plot(freuquencySpectrumAmDemo,frequencyAxis,frequencySpectrumAmDemodulation)
title('AM Demodulated Spectrum');
xlabel ('Frequency');
ylabel ('Amplitude');

% FM modulation spectrum

freuquencySpectrumFMmodulated = subplot(5,1,4);
plot(freuquencySpectrumFMmodulated,frequencyAxis,frequencySpectrumFm)
title('FM Modulated Spectrum');
xlabel('Frequency');
ylabel('Amplitude');

% FM demodulation spectrum

freuquencySpectrumFMdemodulation = subplot(5,1,5);
plot(freuquencySpectrumFMdemodulation,frequencyAxis,frequencySpectrumFmDemodulation)
title('FM Demodulated Spectrum');
xlabel('Frequency');
ylabel('Amplitude');

%% Plot the signal and spectrum together for each signal

% Original signal and spectrum

figure('Name','Plot of original signal and spectrum');
freuquencySpectrumandPlot = subplot(2,1,1);
plot(freuquencySpectrumandPlot,recordedSound);
title('Original Signal');
xlabel('Time');
ylabel('Amplitude'); 


freuquencySpectrumandPlot = subplot(2,1,2);
plot(freuquencySpectrumandPlot,frequencyAxis,frequencySpectrum)
title('Original Signal Spectrum');
xlabel('Frequency');
ylabel('Amplitude'); 

% Trasmitted AM signal and its spectrum

figure('Name','Trasmitted AM signal and its spectrum');

freuquencySpectrumandPlotOfAM = subplot(2,1,1);
plot(freuquencySpectrumandPlotOfAM, modulatedAmSignal);
title('AM Modulated Signal')
xlabel('Time');
ylabel('Amplitude');

freuquencySpectrumandPlotOfAM = subplot(2,1,2);
plot(freuquencySpectrumandPlotOfAM,frequencyAxis,frequencySpectrumAm)
title('AM Modulated Spectrum');
xlabel('Frequency');
ylabel('Amplitude');

% Transmitted FM signal and spectrum

figure('Name','Trasmitted FM signal and its spectrum');

freuquencySpectrumandPlotOfFM = subplot(2,1,1);
plot(freuquencySpectrumandPlotOfFM, modulatedFmSignal);
title('FM Modulated Signal');
xlabel('Time');
ylabel('Amplitude');

freuquencySpectrumandPlotOfFM = subplot(2,1,2);
plot(freuquencySpectrumandPlotOfFM,frequencyAxis,frequencySpectrumFm)
title('FM Modulated Spectrum');
xlabel('Frequency');
ylabel('Amplitude');

% Received AM signal and spectrum

figure('Name','Received AM signal and its spectrum');

freuquencySpectrumandPlotOfAMDemod = subplot(2,1,1);
plot(freuquencySpectrumandPlotOfAMDemod,demodulatedAmSignal);
title('AM Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');

freuquencySpectrumandPlotOfAMDemod = subplot(2,1,2);
plot(freuquencySpectrumandPlotOfAMDemod,frequencyAxis,frequencySpectrumAmDemodulation)
title('AM Demodulated Spectrum');
xlabel ('Frequency');
ylabel ('Amplitude') ;


% Received FM signal and spectrum

figure('Name','Received FM signal and its spectrum');

freuquencySpectrumandPlotOfFMDemod = subplot(2,1,1);
plot(freuquencySpectrumandPlotOfFMDemod, demodulatedFmsignalNorm);
title('FM Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');

freuquencySpectrumandPlotOfFMDemod = subplot(2,1,2);
plot(freuquencySpectrumandPlotOfFMDemod,frequencyAxis,frequencySpectrumFmDemodulation)
title('FM Demodulated Spectrum');
xlabel('Frequency');
ylabel('Amplitude');






