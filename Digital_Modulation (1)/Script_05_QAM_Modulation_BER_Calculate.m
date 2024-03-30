clc; clear all; close all;
% ---> M-QAM
M=16; % sembol sayýsý 
k=log2(M);  % sembol bit sayýsý
n=1e6;   % iþlenecek bit sayýsý
nsamp=1;  % örnek sayýsý

X=randint(n,1);  % rasgele ikilik veri dizisi oluþtur
xsym=bi2de(reshape(X,k,length(X)/k).','left-msb');  % bitleri sembole dönüþtür

Y=qammod(xsym,M);  % QAM modülasyonu uygula
Ytx=Y; % AWGN kanal üzerinden gönderilen sinyal

EbNo=10;  % Bit enerjisinin gürültü gücüne oraný
SNR=EbNo+10*log10(k)-10*log10(nsamp);  % SNR deðeri

% AWGN: Additive White Gaussian Noise 
% Toplamsal Beyaz Gausssian Daðýlýmlý Gürültü

Ynoisy=awgn(Ytx,SNR,'measured'); % alýnan gürültülü sinyal
Yrx=Ynoisy; % alýcýya ulaþan sinyal

zsym=qamdemod(Yrx,M); % QAM demodülasyon
Z=de2bi(zsym,'left-msb');  % sembolleri bit dizisine dönüþtür
Z=reshape(Z.',prod(size(Z)),1); % bit dizisini matristen vektör haline getir

[NBE,BER_Emp]=biterr(X,Z);  % hatalý bit sayýsý ve bit hata oraný hesapla
disp('BER Computed Empirically');
BER_Emp

BER_Teo=berawgn(EbNo,'qam',M);  % Teorik BER hesabý
disp('BER Computed theoretically');
BER_Teo
