
clc; clear all; close all;
M=16; % sembol sayýsý
k=log2(M);  % sembol bit sayýsý
n=6e6;  % iþlenecek bit sayýsý
nsamp=1; % örnek sayýsý
EbNo=[0:14];
l=length(EbNo);
X=randint(n,1);
xsym=bi2de(reshape(X,k,length(X)/k).','left-msb'); % bit-sembol eþleme
Y=pskmod(xsym,M); % PSK Modulasyonu
Ytx=Y;
SNR=EbNo+10*log10(k)-10*log10(nsamp);

for i=1:l
    Ynoisy=awgn(Ytx,SNR(1,i),'measured');
    Yrx=Ynoisy;
    zsym=pskdemod(Yrx,M);
    Z=de2bi(zsym,'left-msb');
    Z=reshape(Z.',prod(size(Z)),1);
    [NBE,BER]=biterr(X,Z);
    ber_emp(1,i)=BER;
    i=i+1;
end

% Teorik BER hesabý
ber_teo=berawgn(EbNo,'psk',M,'nondiff');

figure
semilogy(EbNo,ber_emp,'R-','LineWidth',2); hold on;
semilogy(EbNo,ber_teo,'k*');
xlabel('EbNo (dB)');
ylabel('Bit Error Rate');
legend('Deneysel BER', 'Teorik BER');

grid on;
hold off;

    
    