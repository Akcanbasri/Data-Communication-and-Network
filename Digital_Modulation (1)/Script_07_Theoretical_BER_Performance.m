clc; clear all; close all;

EbNo = (0:10)';
M = 4; % Modulation order

% QPSK
berQ = berawgn(EbNo,'psk',M,'nondiff');
%O-QPSK
berO=berawgn(EbNo,'oqpsk','nondiff');
% DPSK
berD = berawgn(EbNo,'dpsk',M);
% FSK
berF = berawgn(EbNo,'fsk',M,'coherent');
% MSK
berM = berawgn(EbNo,'msk','off');


semilogy(EbNo,[berQ berO berD berF berM])
xlabel('Eb/No (dB)')
ylabel('BER')
legend('QPSK','O-QPSK','DPSK','FSK','MSK')
title("Theoretical Bit Error Rate (BER)")
grid