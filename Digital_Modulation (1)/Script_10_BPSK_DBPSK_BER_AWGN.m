
clc; clear all; close all;

SNRdB = (0:14)';
SNR=10.^(SNRdB/10);
M = 2; % Modulation order

ber_psk = berawgn(SNR,'psk',M,'nondiff');

ber_dpsk = berawgn(SNR,'psk',M,'diff');

semilogy(SNRdB,ber_psk,'b-o','LineWidth',2)
hold on
semilogy(SNRdB,ber_dpsk,'g--s','LineWidth',2)
grid on
axis([min(SNRdB) max(SNRdB) 10^(-8) 1]);
xlabel('SNR [dB]');ylabel('BER');
legend('BPSK','DPSK')

