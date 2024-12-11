import numpy as np
import sounddevice as sd
from scipy.io.wavfile import read
from scipy import signal
from matplotlib import pyplot as plt


def get_audio_fft(audio_data, fs):
    audio_data_fft = np.fft.fft(audio_data)
    magnitude = abs(audio_data_fft)
    freqs = np.fft.fftfreq(len(audio_data), d=1/fs)
    
    return freqs[:len(freqs)//2], magnitude[:len(magnitude)//2] 

def find_noisy_freq(freqs_axis, data_magnitude):
    noisy_f = freqs_axis[np.argmax(data_magnitude)] 
    print('Noisy frequency found to be: ', noisy_f , ' Hz')
    return noisy_f
    
def plot_spectrum(freqs_axis, data_magnitude, noisy_f, title):
    
    magnitude_db = 20*np.log10(data_magnitude + + 1e-10)
    magnitude_normalized = magnitude_db - max(magnitude_db)
    
    plt.plot(freqs_axis, magnitude_normalized, color='orange')
    plt.axvline(noisy_f, label=str(noisy_f)+' Hz', linestyle='--')
    plt.xlim(0, 2000)
    plt.xlabel('Frequency [Hz]')
    plt.ylabel('Relative magnitude [dBV]')
    plt.title(title)
    plt.legend()
    plt.grid(True)
    plt.show()
    
def play_audio(audio_signal, fs):
    sd.play(audio_signal, samplerate=fs)
    sd.wait()
    
def normalize_signal(signal):
    return signal / np.max(np.abs(signal))
    

file_path = "Audio signal 1.wav" 
fs, audio_data = read(file_path)
numtaps = 101 # Vet ikke helt hva vi skal sette denne som ennå
delta_f = 10 / fs

freqs_axis, audio_data_fft_magnitude = get_audio_fft(audio_data, fs)
noisy_f = find_noisy_freq(freqs_axis, audio_data_fft_magnitude)
noisy_f_normalized = noisy_f / fs

# Find filter coefficients
filter_coefficients = signal.firwin(numtaps, [noisy_f_normalized - delta_f, noisy_f_normalized + delta_f], pass_zero=False, fs=fs)
print(filter_coefficients)

# Plot spectrum of audio signal
plot_spectrum(freqs_axis, audio_data_fft_magnitude, noisy_f, "Spectrum of Audio Signal")

# Filter audio signal
audio_filtered = signal.lfilter(filter_coefficients, 1.0, audio_data)

# Find FFT of filtered audio signal and plot the spectrum
filtered_freqs_axis, filtered_audio_fft_magnitude = get_audio_fft(audio_filtered, fs)
plot_spectrum(filtered_freqs_axis, filtered_audio_fft_magnitude, noisy_f, "Filtered Audio Spectrum")

# Normalize audio data signals
audio_data_normalized = normalize_signal(audio_data)
filtered_audio = normalize_signal(audio_filtered)

# Play original audio signal
play_audio(audio_data_normalized, fs)

# Play filtered audio signal
play_audio(filtered_audio, fs)


 
    
    


