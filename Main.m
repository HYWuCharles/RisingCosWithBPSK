%-----------------Main-----------------%
clear;
close all;
clc;

data = 2*(randi(2,[1,50])-1.5);
%8倍过采样
rate = 12;
data_ = zeros(1,length(data)*rate);
data_(1:rate:end) = data;
%for i = 1:1:50
%   if data(1,i) == 0
%       data(1,i) = -1;
%   end
%end


%firrcos(N,Fc,R,Fs,'rolloff','normal')
%N:阶数
%Fc:基带频率
%R:滚降系数
%FS:采样频率
for i = 0.25:0.05:0.75
   figure
   b1 = firrcos(48,0.5,i,rate,'rolloff','normal');
   temp = filter(b1,1,data_);
   subplot(3,1,1)
   plot(b1,'r-')
   subplot(3,1,2)
   %set(gca,'YLim',[-0.1,0.2])
   plot(1:1:length(temp),temp,'r-')
   subplot(3,1,3)
   stem(1:1:length(data),data)
   %title(i)
end

figure                                                                                                                                                                                                                                              
for i = 0.25:0.05:0.75
   b1 = firrcos(48,0.5,i,rate,'rolloff','normal');
   plot(b1)
   hold on
end
title('滚降滤波器')

%基带调制
f = 20;
T = length(data)/f;
dt = 1/(f*rate);
t = 0:dt:T-dt;
carrier_cos = cos(2*pi*f*t);
carrier_cos_1 = cos(2*pi*f*t+pi/2);
B = firrcos(48,0.5,0.5,rate,'rolloff','normal');
data_1 = filter(B,1,data_);
moded = carrier_cos.*data_1;
figure
plot(1:1:length(data_1),moded)
title('BPSK调制信号波形')
xlabel('time')
ylabel('amplitude')
hold on
y = hilbert(moded);
y_b = abs(y);
y_b1 = imag(y);
plot(1:1:length(data_1),y_b,'r')
hold on
plot(1:1:length(data_1),-y_b,'r')