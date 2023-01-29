clear all % On supprime toutes les variables en m�moire
close all % On ferme toutes les fen�tres ouvertes
clc % On vide la console

fe = 1e4; % On d�finit la fr�quence d �chantillonnage
te = 1/fe;% On d�finit la p�riode d'�chentillonnage 
N = 5000; % On d�finit le nombre d �chantillons

t = (0:N-1)*te; % On d�finit l'intervalle du vecteur temps

%% Repr�sentation temporelle et fr�quentielle

% On d�finit lu signal x
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);

% On ouvre une nouvelle fen�tre pour tracer les graphes
figure; 

% Question 1:

% On d�finit la position de la premi�re sous-figure dans un tableau � 2 lignes et 3 colonnes
subplot(2,3,1) 

% On trace le signal x en fonction du temps t
plot(t,x,''); 

% On ajoute un titre au graphe
title('Le signal x(t)')


%Question 2:

% On definit le vecteur de fr�quence f qui correspond � l'�chantillonnage du signal dans l'espace fr�quentiel qui n'est pas centr� sur 0
f =(0:N-1)*(fe/N); 

% calcule la transform�e de Fourier du signal x discret d'une mani�re rapide mais qui n'est pas centr�e sur 0 
y = fft(x); 

% On affiche le spectre d'amplitude
subplot(2,3,2)
plot(f,abs(y));
title("Le spectre d'amplitude")


%Question 3:

%On utilise la commande fshift pour d�finir un vecteur fr�quence centr�
fshift = (-N/2:N/2-1)*(fe/N);
subplot(2,3,3)

% on trace la transform�e de fourier centr�e en fonction de la fr�quence.
plot(fshift,fftshift(2*abs(y)/N))
title("Le spectre d'amplitude centr�")


%Question 4:

% On cr�e un signal de bruit gaussien avec une amplitude de 5 et de la m�me taille que x
noise = 5*randn(size(x));
subplot(2,3,4)
plot(noise)
title("Le signal noise")


%Question 5:

% On ajoute le bruit au signal x
xnoise = x+noise;


%Question 6:

% On calcule la transform�e de Fourier du signal bruit�
ybruit = fft(xnoise);
subplot(2,3,5)

% On trace la transform�e de Fourier centr�e du signal bruit� en fonction de la fr�quence
plot(fshift,fftshift((abs(ybruit)*2)/N));
title("Le signal noise ")


%Question 7:
figure;

%On cr�e un signal de bruit gaussien avec une amplitude de 20 et de la m�me taille que x
noise2 = 20*randn(size(x));
xnoise2=x+noise2;
ybruit2 = fft(xnoise2);
plot(fshift,fftshift((abs(ybruit2))*2/N));
title("Le signal noise 2")


%Apr�s l'augmentation de l'intensit� du bruit, le spectre est envahi par
%le signal contenant les informations pertinentes, rendant l'extraction et
%le filtrage de xnoise2 difficile.

%% Analyse fr�quentielle du son du rorqual bleu

%Question 1:

% On lit le fichier audio "bluewhale.au" et on enregistre les donn�es dans la variable "whale" et la fr�quence d'�chantillonnage dans "fe"
[whale,fe]=audioread("bluewhale.au"); 
%On d�finit un sous-signal "son" dans le signal "whale"
son = whale(2.45e4:3.10e4); 

%Question 2:

% On joue le sous-signal "son" � la fr�quence d'�chantillonnage "fe"
sound(son,fe)

%Question 3:

%d�finit le nombre d'�chantillons (N) comme �tant �gal � la longueur du sous-signal "son"
N = length(son);
te = 1/fe;
t = (0:N-1)*(10*te);
figure;
subplot(2,1,1)
plot(t,son)
title('Le signal whant')

% On calcule la densit� spectrale de puissance du sous-signal "son"
y = abs(fft(son)).^2/N; 

% On d�finit le vecteur fr�quence (f) 
f = (0:floor(N/2))*(fe/N)/10;
subplot(2,1,2)
plot(f,y(1:floor(N/2)+1));
title('Le signal densit� spectrale de puissance du signal')