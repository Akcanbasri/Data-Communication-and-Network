clc; clear all; close all;
M=16; % sembol say�s�
k=log2(M);  % sembol bit say�s�
n=1e6;  % i�lenecek bit say�s�
nsamp=1; % �rnek say�s�
X=randint(n,1); % rasgele bit dizisi �ret
xsym=bi2de(reshape(X,k,length(X)/k).','left-msb'); % bit-sembol e�leme
Y_qam=qammod(xsym,M); % QAM Modulasyonu
Y_psk=pskmod(xsym,M); % PSK Modulasyonu
Ytx_qam=Y_qam; % g�nderilen sinyal QAM
Ytx_psk=Y_psk; % g�nderilen sinyal PSK

% AWGN kanal �zerinden g�nder
EbNo=10; % SNR (dB)
SNR=EbNo+10*log10(k)-10*log10(nsamp);
Ynoisy_qam=awgn(Ytx_qam,SNR,'measured');
Ynoisy_psk=awgn(Ytx_psk,SNR,'measured');
Yrx_qam=Ynoisy_qam; % al�nan sinyal QAM
Yrx_psk=Ynoisy_psk; % al�nan sinyal PSK

h1=scatterplot(Yrx_qam(1:nsamp*5e3),nsamp,0,'r.');
hold on
scatterplot(Ytx_qam(1:5e3),1,0,'k*',h1);
title('Yildiz Kumesi Diyagrami 16 QAM');
legend('Alinan Sinyal','Sinyal Uzayi');
axis([-5 5 -5 5]);
hold off;

h2=scatterplot(Yrx_psk(1:nsamp*5e3),nsamp,0,'r.');
hold on;
scatterplot(Ytx_psk(1:5e3),1,0,'k*',h2);
title('Yildiz Kumesi Diyagrami 16 PSK');
legend('Alinan Sinyal','Sinyal Uzayi');
axis([-5 5 -5 5]);
hold off;






