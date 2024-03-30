
clc
close all
clear all

x=(0:0.1:10)';

q1=qfunc(x);

plot(x,q1,'r-','LineWidth',2);
grid on
xlabel('x');ylabel('Q(x)');

