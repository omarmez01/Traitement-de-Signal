clear all
close all
clc


%% Suppression du bruit provoqu� par les mouvements 
figure;
%Question 1:

% On charge les donn�es stock�es dans un fichier nomm� "ecg.mat" et enregistre les donn�es dans la variable "x"
load("ecg.mat"); 

% On enregistre les donn�es de "ecg" dans la variable "x"
x=ecg;


%Question 2:

fs=500;

% On d�finit le nombre d'�chantillons (N) comme �tant �gal � la longueur du signal "x"
N = length(x); 
ts=1/fs;
t=(0:N-1)*ts;
subplot(1,3,1)
plot(t,x);
title("le signal ECG ");

%xlim([0.5 1.5]) %On peut utiliser cette commande pour zoomer sur une p�riode

%Question 3:

% On calcule la transform�e de Fourier du signal "x"
y = fft(x);

% On d�finit un vecteur fr�quence (f)
f =(0:N-1)*(fs/N);

% On d�finit un vecteur fr�quence (f2)
f2 = (-N/2:N/2-1)*(fs/N);
subplot(1,3,2)
plot(f2,fftshift(abs(y))) 
title("spectre Amplitude du signal ECG")

% On cr�e un filtre passe-haut de m�me dimension que le signal x
filtre_haut = ones(size(x));

% On d�finit la fr�quence de coupure du filtre 
fc = 0.5;
index_h = ceil(fc*N/fs); % La fonction "ceil" arrondit au nombre entier sup�rieur

% On met � 0 les valeurs de fr�quence inf�rieures � la fr�quence de coupure
filtre_haut(1:index_h)=0; 
filtre_haut(N-index_h+1:N)=0; 

% On applique le filtre � la transform�e de fourier du signal x.
filtre=filtre_haut.*y;

% On calcule la transform�e inverse de Fourier pour obtenir le signal filtr� "ecg1"
ecg1=ifft(filtre,"symmetric");

%Question 4:
subplot(1,3,3)
plot(t,ecg1);
title("signal filtre ecg1")


%En comparant les signaux x(ecg) et ecg1, on peut constater que les grandes
% oscillations du signal ont �t� �limin�es, ce qui indique que les 
% oscillations de grande p�riode (c'est-�-dire les basses fr�quences) ont 
% �t� efficacement supprim�es par le filtre passe-haut

 %% Suppression des interf�rences des lignes �lectriques 50Hz
% Filtre Notch

%  transformation de fourrier du signal filtr�e
subplot(2,3,4)
plot(f2,fftshift(abs(fft(ecg1))))
title("TF de ecg1")




%Question 5:
figure;

% On cr�e un filtre notch de m�me dimension que le signal "x" en initialisant toutes les valeurs � 1
notch_filter = ones(size(x)); 

% On d�finit la fr�quence de coupure du filtre notch � 50 Hz
fc2 = 50;

% On calcule l'index de la fr�quence de coupure
index_h2 = ceil((fc2*N)/fs)+1; 

% On met � 0 les valeurs de fr�quence � la fr�quence de coupure dans le filtre notch
notch_filter(index_h2)= 0;
notch_filter(N-index_h2+2)= 0; 

% On applique le filtre notch � la sortie du filtre passe-haut.
filtre2=notch_filter.*filtre;

%Question 6:

% On calcule la transform�e inverse de Fourier pour obtenir le signal filtr� "ecg2"
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


%% Am�lioration du rapport signal sur bruit



%Question 7:

%Filtrage passe-bas
figure;

% On cr�e un filtre passe-bas de m�me dimension que le signal x
filtre_bas = zeros(size(x));

% On modifie la fr�quence � chaque it�ration et on essaie de rapprocher le r�sultat obtenu de la repr�sentation du signal ECG sans bruit
fc3 = 37;
index_h3 = ceil(fc3*N/fs);

% On met � 1 les valeurs de fr�quence inf�rieures � la fr�quence de coupure dans le filtre passe-bas
filtre_bas(1:index_h3)=1;

% % On l'utilise pour appliquer la sym�trie conjugu�
filtre_bas(N-index_h3+1:N)=1; 

% On applique le filtre passe-bas � la sortie du filtre notch
ecg3_freq =  filtre_bas.*fft(ecg2);

% On calcule la transform�e inverse de Fourier pour obtenir le signal filtr� "ecg3"
ecg3 = ifft(ecg3_freq,"symmetric");



%Apr�s avoir effectu� plusieurs tests, nous avons r�ussi � identifier le 
% filtre appropri� qui est situ� � 37 Hz. M�me s'il reste du bruit au-del�
% de cette fr�quence, il est encombr� par des informations pertinentes. 
% Si nous augmentions la fr�quence de coupure, nous perdrions des 
% informations qui peuvent �tre observ�es sous forme de d�formation des 
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

%% Identification de la fr�quence cardiaque avec la fonction d�autocorr�lation

%Question 9:

figure;

% On l'utilise pour calculer la corr�lation crois�e
[acf,lags] = xcorr(ecg3,ecg3); 

% On l'utilise pour tracer les r�sultats de la corr�lation crois�e entre les deux signaux
stem(lags/fs,acf)

