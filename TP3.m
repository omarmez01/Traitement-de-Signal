clear all
close all
clc


%% Suppression du bruit provoqué par les mouvements 
figure;
%Question 1:

% On charge les données stockées dans un fichier nommé "ecg.mat" et enregistre les données dans la variable "x"
load("ecg.mat"); 

% On enregistre les données de "ecg" dans la variable "x"
x=ecg;


%Question 2:

fs=500;

% On définit le nombre d'échantillons (N) comme étant égal à la longueur du signal "x"
N = length(x); 
ts=1/fs;
t=(0:N-1)*ts;
subplot(1,3,1)
plot(t,x);
title("le signal ECG ");

%xlim([0.5 1.5]) %On peut utiliser cette commande pour zoomer sur une période

%Question 3:

% On calcule la transformée de Fourier du signal "x"
y = fft(x);

% On définit un vecteur fréquence (f)
f =(0:N-1)*(fs/N);

% On définit un vecteur fréquence (f2)
f2 = (-N/2:N/2-1)*(fs/N);
subplot(1,3,2)
plot(f2,fftshift(abs(y))) 
title("spectre Amplitude du signal ECG")

% On crée un filtre passe-haut de même dimension que le signal x
filtre_haut = ones(size(x));

% On définit la fréquence de coupure du filtre 
fc = 0.5;
index_h = ceil(fc*N/fs); % La fonction "ceil" arrondit au nombre entier supérieur

% On met à 0 les valeurs de fréquence inférieures à la fréquence de coupure
filtre_haut(1:index_h)=0; 
filtre_haut(N-index_h+1:N)=0; 

% On applique le filtre à la transformée de fourier du signal x.
filtre=filtre_haut.*y;

% On calcule la transformée inverse de Fourier pour obtenir le signal filtré "ecg1"
ecg1=ifft(filtre,"symmetric");

%Question 4:
subplot(1,3,3)
plot(t,ecg1);
title("signal filtre ecg1")


%En comparant les signaux x(ecg) et ecg1, on peut constater que les grandes
% oscillations du signal ont été éliminées, ce qui indique que les 
% oscillations de grande période (c'est-à-dire les basses fréquences) ont 
% été efficacement supprimées par le filtre passe-haut

 %% Suppression des interférences des lignes électriques 50Hz
% Filtre Notch

%  transformation de fourrier du signal filtrée
subplot(2,3,4)
plot(f2,fftshift(abs(fft(ecg1))))
title("TF de ecg1")




%Question 5:
figure;

% On crée un filtre notch de même dimension que le signal "x" en initialisant toutes les valeurs à 1
notch_filter = ones(size(x)); 

% On définit la fréquence de coupure du filtre notch à 50 Hz
fc2 = 50;

% On calcule l'index de la fréquence de coupure
index_h2 = ceil((fc2*N)/fs)+1; 

% On met à 0 les valeurs de fréquence à la fréquence de coupure dans le filtre notch
notch_filter(index_h2)= 0;
notch_filter(N-index_h2+2)= 0; 

% On applique le filtre notch à la sortie du filtre passe-haut.
filtre2=notch_filter.*filtre;

%Question 6:

% On calcule la transformée inverse de Fourier pour obtenir le signal filtré "ecg2"
ecg2=ifft(filtre2,"symmetric");
subplot(1,3,1)
plot(f2,fftshift(abs(filtre2)));
title("Spectre de ECG2")
subplot(1,3,2)
plot(t,ecg2);
title("Signal  ECG2")

% subplot(211)
% plot(t,x)
% xlim([0.5 1.5])
% subplot(212)
% plot(t,ecg2)
% xlim([0.5 1.5])


%% Amélioration du rapport signal sur bruit



%Question 7:

%Filtrage passe-bas
figure;

% On crée un filtre passe-bas de même dimension que le signal x
filtre_bas = zeros(size(x));

% On modifie la fréquence à chaque itération et on essaie de rapprocher le résultat obtenu de la représentation du signal ECG sans bruit
fc3 = 37;
index_h3 = ceil(fc3*N/fs);

% On met à 1 les valeurs de fréquence inférieures à la fréquence de coupure dans le filtre passe-bas
filtre_bas(1:index_h3)=1;

% % On l'utilise pour appliquer la symétrie conjugué
filtre_bas(N-index_h3+1:N)=1; 

% On applique le filtre passe-bas à la sortie du filtre notch
ecg3_freq =  filtre_bas.*fft(ecg2);

% On calcule la transformée inverse de Fourier pour obtenir le signal filtré "ecg3"
ecg3 = ifft(ecg3_freq,"symmetric");



%Après avoir effectué plusieurs tests, nous avons réussi à identifier le 
% filtre approprié qui est situé à 37 Hz. Même s'il reste du bruit au-delà
% de cette fréquence, il est encombré par des informations pertinentes. 
% Si nous augmentions la fréquence de coupure, nous perdrions des 
% informations qui peuvent être observées sous forme de déformation des 
% ondes et de l'onde T qui compose le signal ECG



 %Question 8:
 
 
subplot(1,3,1)
plot(t,x)
xlim([0.5 1.5])
title('signal de depart ecg')
subplot(1,3,2)
plot(t,ecg3)
xlim([0.5 1.5])
title('signal ecg3')

%% Identification de la fréquence cardiaque avec la fonction d’autocorrélation

%Question 9:

figure;

% On l'utilise pour calculer la corrélation croisée
[acf,lags] = xcorr(ecg3,ecg3); 

% On l'utilise pour tracer les résultats de la corrélation croisée entre les deux signaux
stem(lags/fs,acf)

