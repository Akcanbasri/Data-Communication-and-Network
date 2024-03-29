%% Shows and selects the input audio device

function [inputDeviceNumber] = inputDeviceInformation()   
    deviceInfo = audiodevinfo;
    inputDeviceInfo = struct2table(deviceInfo.input);
    
    disp(inputDeviceInfo);
    
    
    inputDeviceNumber = input("Select the audio device for recording from list = ");
    
end
