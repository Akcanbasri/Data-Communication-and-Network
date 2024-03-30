clc; clear all, close all;
x=input('Mesaj sinyali bit dizisini girin, x:');
T=input('Bit süresini girin (milisaniye), T:');
fc=input('Taþýyýcý frekansýný girin (Kilo Hertz), fc:');
Ac=input('Taþýyýcý genliðini girin, Ac:');

t=[]; m=[];
n=numel(x);

for i=1:n
    temp=(i-1)*T:0.001:i*T;
    if (x(i)==1)
        x1=ones(1,numel(temp));
    elseif (x(i)==0)
        x1=zeros(1,numel(temp));
    end    
    t=[t,temp];
    m=[m,x1];
    i=i+1;
end
c=Ac*sin(2*pi*fc*t);
y=m.*c;
subplot(311);
plot(t,m);
title('Mesaj Sinyali');
ylabel('Genlik');
axis([0 10 -2 2]);
subplot(312);
plot(t,c);
title('Tasiyici Sinyal');
ylabel('Genlik');
axis([0 10 -2 2]);
subplot(313);
plot(t,y);
title('BASK Sinyali');
ylabel('Genlik');
xlabel('Zaman (ms)');
axis([0 10 -2 2]);









