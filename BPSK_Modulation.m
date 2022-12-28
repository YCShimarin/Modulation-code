%BPSK
clc
% Data Here
nama=input('Input your name : ', "s");
ascii = int8(nama);
asciibin = dec2bin(ascii,8);
b = asciibin';
c = str2num(b(:)); 
bitdata = c;


fc = 1;
fs = 30*fc; 
ts = 1/fs;
bitlen = length(bitdata);
Bitrate = 01;
t_akhir=bitlen/Bitrate;
t = 0 : ts : t_akhir;
len_t = length(t);
t = t(1:len_t-1);

 % Oscilator Carrier Here
sc = sin(2*pi*fc*t);

data_len = length(bitdata);
        for i = 1:data_len
            if (bitdata(i) ==  0)
                NRZ_sign(i) = -1;
            else
                NRZ_sign(i) = 1;
            end
        end

sampleperbit = fs/Bitrate;
    sign_s = [];
    
    % Quadrature Digital Signal
        for i = 1:data_len
            sign = NRZ_sign(i)*ones(1,sampleperbit);
            sign_s = [sign_s sign];
        end

BPSK_Sign = sign_s.*sc;  % BPSK

subplot(3,1,1)
plot(t,sc,'r',LineWidth=2)
title('BPSK Modulated Signal')
xlabel('Time (t)')
ylabel('Amplitude')
axis([0 t(end) -1.5 1.5]);

subplot(3,1,2)
plot(t,sign_s,'r',LineWidth=2)
title('BPSK Modulated Signal')
xlabel('Time (t)')
ylabel('Amplitude')
axis([0 t(end) -1.5 1.5]);

subplot(3,1,3)
plot(t,BPSK_Sign,'r',LineWidth=2)
title('BPSK Modulated Signal')
xlabel('Time (t)')
ylabel('Amplitude')
axis([0 t(end) -1.5 1.5]);
