%% Sets up the recorder

function [recordedVoice,audioVoice] = audioRecorder(samplingFrequency,bitResolution,channel,deviceNumber,recordTime)
    audioVoice = audiorecorder(samplingFrequency,bitResolution,channel, deviceNumber);
    recordblocking(audioVoice,recordTime);
    recordedVoice = getaudiodata(audioVoice);
    
end

    

