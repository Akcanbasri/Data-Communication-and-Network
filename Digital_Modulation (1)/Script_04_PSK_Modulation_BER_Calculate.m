clc; clear all; close all;
% ---> M-PSK
M=4; % sembol sayısı M=4 ise QPSK
k=log2(M);  % sembol bit sayısı
n=1e6;   % işlenecek bit sayısı
nsamp=1;  % örnek sayısı

X=randint(n,1);  % rasgele ikilik veri dizisi oluştur
xsym=bi2de(reshape(X,k,length(X)/k).','left-msb');  % bitleri sembole dönüştür

Y=pskmod(xsym,M);  % QAM modülasyonu uygula
Ytx=Y; % AWGN kanal üzerinden gönderilen sinyal

EbNo=10;  % Bit enerjisinin gürültü gücüne oranı
SNR=EbNo+10*log10(k)-10*log10(nsamp);  % SNR değeri

% AWGN: Additive White Gaussian Noise 
% Toplamsal Beyaz Gausssian Dağılımlı Gürültü

Ynoisy=awgn(Ytx,SNR,'measured'); % alınan gürültülü sinyal
Yrx=Ynoisy; % alıcıya ulaşan sinyal

zsym=pskdemod(Yrx,M); % QAM demodülasyon
Z=de2bi(zsym,'left-msb');  % sembolleri bit dizisine dönüştür
Z=reshape(Z.',prod(size(Z)),1); % bit dizisini matristen vektör haline getir

[NBE,BER_Emp]=biterr(X,Z);  % hatalı bit sayısı ve bit hata oranı hesapla
disp('BER Computed Empirically');
BER_Emp

BER_Teo=berawgn(EbNo,'psk',M,'diff');  % Teorik BER hesabı
disp('BER Computed theoretically');
BER_Teo
