function wavelet_intro
% WAVELET_INTRO Comparison between frequency analysis with fft and wavelet
% transform.

    clearvars;

    % parameters 

    Fs = 100;
    T = 1 / Fs;
    L = 250;
    Tp = T * L;
    F = 1 / Tp;
    t = (0:L-1) * T; % time

    % Domains: I = Z(T)/Z(Tp), Î = Z(F)/Z(Fs)

    % 1. Frequency content and abrupt changes
    s1 = 2 * sin(2*pi*10*F*t) + sin(2*pi*50*F*t); % two tones
    % and on pulse
    s1(L/2) = s1(L/2) + 10;

    plot(t, s1);
    title('Signal 1');
    xlabel('Time [s]');
    ylabel('Amplitude');
    shg;
    pause;

    % fft analysis
    spectrogram(s1);
    shg;
    pause;

    % wavelet analysis
    cwt(s1, Fs);
    shg;
    pause;


    % 2. Pattern over time
    % Here we define a sin with exponential increasing frequency

    s2_f = exp(t); % signal 2 frequency

    % display frequency over time
    plot(t, s2_f);
    title('Frequency of sin over time');
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');
    shg;
    pause;

    s2 = sin(2*pi*F*s2_f.*t); % signal 2

    % display signal 2 over time
    plot(t, s2);
    title('Signal 2');
    ylabel('Amplitude');
    xlabel('Time [s]');
    shg;
    pause;

    % fft analysis
    fourier_s2 = T * fft(s2);
    f = Fs * (0:L/2) / L;
    plot(f, abs(fourier_s2(1:length(f))));
    title('fft of Signal 2');
    ylabel('|S2(f)|');
    xlabel('Frequency [Hz]');
    shg;
    pause;

    % wavelet analysis
    cwt(s2, Fs); % frequency is plotted in log scale, so the exponential increasing frequency should result in a line






end