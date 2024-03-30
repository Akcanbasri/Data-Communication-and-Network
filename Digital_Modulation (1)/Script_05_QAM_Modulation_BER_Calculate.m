clc; clear all; close all;
% ---> M-QAM
M=16; % sembol say�s� 
k=log2(M);  % sembol bit say�s�
n=1e6;   % i�lenecek bit say�s�
nsamp=1;  % �rnek say�s�

X=randint(n,1);  % rasgele ikilik veri dizisi olu�tur
xsym=bi2de(reshape(X,k,length(X)/k).','left-msb');  % bitleri sembole d�n��t�r

Y=qammod(xsym,M);  % QAM mod�lasyonu uygula
Ytx=Y; % AWGN kanal �zerinden g�nderilen sinyal

EbNo=10;  % Bit enerjisinin g�r�lt� g�c�ne oran�
SNR=EbNo+10*log10(k)-10*log10(nsamp);  % SNR de�eri

% AWGN: Additive White Gaussian Noise 
% Toplamsal Beyaz Gausssian Da��l�ml� G�r�lt�

Ynoisy=awgn(Ytx,SNR,'measured'); % al�nan g�r�lt�l� sinyal
Yrx=Ynoisy; % al�c�ya ula�an sinyal

zsym=qamdemod(Yrx,M); % QAM demod�lasyon
Z=de2bi(zsym,'left-msb');  % sembolleri bit dizisine d�n��t�r
Z=reshape(Z.',prod(size(Z)),1); % bit dizisini matristen vekt�r haline getir

[NBE,BER_Emp]=biterr(X,Z);  % hatal� bit say�s� ve bit hata oran� hesapla
disp('BER Computed Empirically');
BER_Emp

BER_Teo=berawgn(EbNo,'qam',M);  % Teorik BER hesab�
disp('BER Computed theoretically');
BER_Teo
