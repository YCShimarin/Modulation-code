 clearvars, clc, close all

%% ================ Data Explain

    % Communication system task 
    % Quadrature Phase Shift Keying

%% =============== Data Part

nama=input('Input your name : ', "s");
ascii = int8(nama);
asciibin = dec2bin(ascii,8);
b = asciibin';
c = str2num(b(:)); 
data = c;


fc = 2;
fs = 30*fc; 
ts = 1/fs;
bitlen = length(data);
Bitrate = 01;
t_akhir=bitlen/Bitrate;
t = 0 : ts : t_akhir/2;
len_t = length(t);
t = t(1:len_t-1);


% ================ Demultiplexer data Signal

Quadrature = data(1: 2:end);
InPhase = data(2:2:end);

% ================ Oscilator 
    % Quadrature carrier
        sc_quad = sin(2*pi*fc*t);
    % In Phase carrier 
        sc_ip = cos(2*pi*fc*t);
% ================ NRZ Polar Encoding
    % NRZ Quadrature
    quad_len = length(Quadrature);
        for i = 1:quad_len
            if (Quadrature(i) ==  0)
                NRZ_quad(i) = -1;
            else
                NRZ_quad(i) = 1;
            end
        end
    % NRZ In Phase
    ip_len = length(InPhase);
        for i = 1: ip_len
            if (InPhase(i) ==  0)
                NRZ_ip(i) = -1;
            else
                NRZ_ip(i) = 1;
            end
        end
% ================ Digital Signal
    sampleperbit = fs/Bitrate;
    si_q = [];
    si_ip = [];
    
    % Quadrature Digital Signal
        for i = 1:quad_len
            sq = NRZ_quad(i)*ones(1,sampleperbit);
            si_q = [si_q sq];
        end
     % InPhase Digital Signal
        for i = 1:ip_len
            si = NRZ_ip(i)*ones(1,sampleperbit);
            si_ip = [si_ip si];
        end
figure(1)
subplot(2,1,1)
plot(t,si_q,'r',LineWidth=2)
title('Quadrature Digital Signal')
xlabel('Time (t)')
ylabel('Amplitude')
axis([0 t(end) -1.5 1.5]);

subplot(2,1,2)
plot(t,si_ip,'b',LineWidth=2)
title('In-Phase Digital Signal')
xlabel('Time (t)')
ylabel('Amplitude')
axis([0 t(end) -1.5 1.5]);

% ================ Quadrature and InPhase Signal

Quadrature_Signal = si_q.*sc_quad;  % Quadrature part
InPhase_signal = si_ip.*sc_ip;      % In-Phase part

figure(2)
subplot(3,1,1)
plot(t,Quadrature_Signal,'r',LineWidth=2)
title('Quadrature Modulated Signal')
xlabel('Time (t)')
ylabel('Amplitude')
axis([0 t(end) -1.5 1.5]);

subplot(3,1,2)
plot(t,InPhase_signal,'r',LineWidth=2)
title('In-Phase Modulated Signal')
xlabel('Time (t)')
ylabel('Amplitude')
axis([0 t(end) -1.5 1.5]);

% ================ QPSK Modulation

QPSK = Quadrature_Signal+InPhase_signal;

subplot(3,1,3)
plot(t,QPSK,'b',LineWidth=2)
title('QPSK Modulated Signal')
xlabel('Time (t)')
ylabel('Amplitude') 
axis([0 t(end) -1.5 1.5]);


