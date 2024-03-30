clc; clear all, close all;
x=input('Mesaj sinyali bit dizisini girin, x:');
T=input('Bit süresini girin (milisaniye), T:');
fc1=input('1 biti için taþýyýcý frekansýný girin (Kilo Hertz), fc1:');
fc2=input('0 biti için taþýyýcý frekansýný girin (Kilo Hertz), fc2:');
Ac=input('Taþýyýcý genliðini girin, Ac:');

t=[]; m=[]; y=[];
n=numel(x);

for i=1:n
    temp=(i-1)*T:0.001:i*T;
    if (x(i)==1)
        x1=ones(1,numel(temp));
        z=Ac*sin(2*pi*fc1*temp);
        y=[y,z];
    elseif (x(i)==0)
        x1=zeros(1,numel(temp));
        z=Ac*sin(2*pi*fc2*temp);
        y=[y,z];
    end    
    t=[t,temp];
    m=[m,x1];
    i=i+1;
end

c1=Ac*sin(2*pi*fc1*t);
c2=Ac*sin(2*pi*fc2*t);

subplot(221);
plot(t,m);
title('Mesaj Sinyali');
ylabel('Genlik');
axis([0 10 -2 2]);
subplot(222);
plot(t,c1);
title('1 Biti icin Tasiyici Sinyal');
ylabel('Genlik');
axis([0 10 -2 2]);
subplot(223);
plot(t,c2);
title('0 Biti icin Tasiyici Sinyal');
ylabel('Genlik');
xlabel('Zaman (ms)');
axis([0 10 -2 2]);
subplot(224);
plot(t,y);
title('BFSK Sinyali');
ylabel('Genlik');
xlabel('Zaman (ms)');
axis([0 10 -2 2]);



