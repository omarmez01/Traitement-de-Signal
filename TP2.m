clear all
close all
clc
%% Jeux de mots
%Question 1:

% On lit un fichier audio nommé "sound.au"
[x,fe]=audioread("sound.au"); 

%Question 2:

%sound(x,fe)
%plot(x)

%Question 3:

%sound(x,fe*2)
%sound(x,fe/2)
%sound(x,fe)



%Question 4:

stem(x)

% En analysant le tracé de la fonction x on peut identifier que le morceau 

%Question 5:


riennesertde=x(1025:(2.05e05));
%stem(riennesertde)
%sound(riennesertde,fe)

%Question 6:

courir=x((2.239e+05):(2.642e+05));
%sound(courir,fe)

ilfaut=x((2.987e+05):(3.81e+05));
%sound(ilfaut,fe)

partirapoint=x((4e+05):(5.28e+05));
%sound(partirapoint,fe)



%Question 7:
parole=[riennesertde ,partirapoint ,ilfaut,courir];
%sound(parole,fe)


%% Synthèse et analyse spectrale d’une gamme de musique

%Synthèse d’une gamme de musique

%Question 1:

fe=8192;
te=1/fe;
N=5000;
t=(0:N-1)*te;
do=10*cos(2*pi*262*t);
%sound(do,fe)
re=10*cos(2*pi*294*t);
%sound(re,fe)
mi=10*cos(2*pi*330*t);
%sound(mi,fe)
fa=10*cos(2*pi*349*t);
%sound(re,fa)
sol=10*cos(2*pi*392*t);
%sound(sol,fe)
la=10*cos(2*pi*440*t);
%sound(la,fe)
si=10*cos(2*pi*494*t);
%sound(si,fe)
do2=10*cos(2*pi*523*t);
%sound(do2,fe)
musique=[do,re,mi,fa,sol,la,si,do2];
sound(musique,fe)
 

%Spectre de la gamme de musique

%Question 2:

f=(0:N-1)*(fe/N);

% On centree les fréquences autour de zéro avant de passer le spectre à la fonction "abs" pour obtenir les valeurs absolues des amplitudes des fréquences.

spectre_musique=fft(musique);

% On affiche graphiquement le spectre de la musique, permettant ainsi de visualiser les différentes fréquences présentes dans le morceau.
signalAnalyzer(abs(fftshift(spectre_musique)));
