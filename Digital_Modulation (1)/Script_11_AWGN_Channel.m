clc
close all
clear all

M=2;
n=1e6;
SNR=10;

DataIn=randi([0,M-1],n,1);

TxSignal=pskmod(DataIn,M,0);
scatterplot(TxSignal)

RxSignal=awgn(TxSignal,SNR);
scatterplot(RxSignal)

DataOut=pskdemod(RxSignal,M,0);

NSE=symerr(DataIn,DataOut);
disp("Hatalı sembol sayısı:");
NSE

[NBE,BER_awgn]=biterr(DataIn,DataOut);
disp("Hatalı bit sayısı:");
NBE
disp("Bit Hata Oranı:");
BER_awgn

Teo_BER=berawgn(SNR,'psk',M,'nondiff');
disp("Teorik BER Değeri:");
Teo_BER


% BER BER
Teo_BER_F=qfunc(sqrt(2*SNR));
disp("Formülle Hesaplanan Teorik BER Değeri:");
Teo_BER_F
