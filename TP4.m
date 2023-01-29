clear all
close all
clc

Te = 5*1e-4;
f1 = 500;
f2 = 400;
f3 = 50;
t = 0:Te:5-Te;
fe = 1/Te;
N = length(t);

fshift = (-N/2:N/2-1)*(fe/N);
f = (0:N-1)*(fe/N);

x = sin(2*pi*f1*t)+sin(2*f2*pi*t)+sin(2*pi*f3*t);
y = fft(x);

%subplot(2,1,1)
%plot(t,x)
%subplot(2,1,2)
%plot(fshift, fftshift(abs(y)));


% On définit les constantes
k = 1;
wc = 50;
wc1 = 500;
wc2 = 1000;


%On définit les fonctions complexes dépendantes de f
h = (k*1j*((2*pi*f)/wc))./(1+1j*((2*pi*f)/wc));
h1 = (k*1j*((2*pi*f)/wc1))./(1+1j*((2*pi*f)/wc1));
h2 = (k*1j*((2*pi*f)/wc2))./(1+1j*((2*pi*f)/wc2));


% On définit les modules exprimés en décibels
G = 20*log(abs(h));
G1 = 20*log(abs(h1));
G2 = 20*log(abs(h2));


%On défiit les angles
P = angle(h);
P1 = angle(h1);
P2 = angle(h2);

% Il y a trois sous-diagrammes qui sont créés, le premier trace abs(h) et le deuxième trace G, G1 et G2 et le troisième trace P, P1 et P2


subplot(3,1,1)

% On trace les courbes sur un graphique en coordonnées logarithmiques
semilogx(abs(h))
plot(abs(h))

%On donne une légende à la figure
legend("Module de h(t)")

subplot(3,1,2)
semilogx(f,G,f,G1,f,G2);
title("Diagramme de Bode")
xlabel("rad/s")
ylabel("decibel")
legend("G : wc=50","G1 : wc=500","G2 : wc=1000")

subplot(3,1,3)
semilogx(f,P,f,P1,f,P2)
%legend("P","P1","P2")

%On charge le signal sonore
[x,fs] = audioread('test.wav');

% On défini les paramètres du filtre
fc = 3000;
n = 4;

% On crée le filtre 
[b,acf] = butter(n,fc/(fs/2), 'low');

% On applique le filtre au signal
y = filter(b,acf,x);

%On enregiste le signal filtré 
audiowrite('signal_filtre.wav',y,fs)