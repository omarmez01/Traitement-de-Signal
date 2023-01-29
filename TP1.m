clear all % On supprime toutes les variables en mémoire
close all % On ferme toutes les fenêtres ouvertes
clc % On vide la console

fe = 1e4; % On définit la fréquence d échantillonnage
te = 1/fe;% On définit la période d'échentillonnage 
N = 5000; % On définit le nombre d échantillons

t = (0:N-1)*te; % On définit l'intervalle du vecteur temps

%% Représentation temporelle et fréquentielle

% On définit lu signal x
x = 1.2*cos(2*pi*440*t+1.2)+3*cos(2*pi*550*t)+0.6*cos(2*pi*2500*t);

% On ouvre une nouvelle fenêtre pour tracer les graphes
figure; 

% Question 1:

% On définit la position de la première sous-figure dans un tableau à 2 lignes et 3 colonnes
subplot(2,3,1) 

% On trace le signal x en fonction du temps t
plot(t,x,''); 

% On ajoute un titre au graphe
title('Le signal x(t)')


%Question 2:

% On definit le vecteur de fréquence f qui correspond à l'échantillonnage du signal dans l'espace fréquentiel qui n'est pas centré sur 0
f =(0:N-1)*(fe/N); 

% calcule la transformée de Fourier du signal x discret d'une manière rapide mais qui n'est pas centrée sur 0 
y = fft(x); 

% On affiche le spectre d'amplitude
subplot(2,3,2)
plot(f,abs(y));
title("Le spectre d'amplitude")


%Question 3:

%On utilise la commande fshift pour définir un vecteur fréquence centré
fshift = (-N/2:N/2-1)*(fe/N);
subplot(2,3,3)

% on trace la transformée de fourier centrée en fonction de la fréquence.
plot(fshift,fftshift(2*abs(y)/N))
title("Le spectre d'amplitude centré")


%Question 4:

% On crée un signal de bruit gaussien avec une amplitude de 5 et de la même taille que x
noise = 5*randn(size(x));
subplot(2,3,4)
plot(noise)
title("Le signal noise")


%Question 5:

% On ajoute le bruit au signal x
xnoise = x+noise;


%Question 6:

% On calcule la transformée de Fourier du signal bruité
ybruit = fft(xnoise);
subplot(2,3,5)

% On trace la transformée de Fourier centrée du signal bruité en fonction de la fréquence
plot(fshift,fftshift((abs(ybruit)*2)/N));
title("Le signal noise ")


%Question 7:
figure;

%On crée un signal de bruit gaussien avec une amplitude de 20 et de la même taille que x
noise2 = 20*randn(size(x));
xnoise2=x+noise2;
ybruit2 = fft(xnoise2);
plot(fshift,fftshift((abs(ybruit2))*2/N));
title("Le signal noise 2")


%Après l'augmentation de l'intensité du bruit, le spectre est envahi par
%le signal contenant les informations pertinentes, rendant l'extraction et
%le filtrage de xnoise2 difficile.

%% Analyse fréquentielle du son du rorqual bleu

%Question 1:

% On lit le fichier audio "bluewhale.au" et on enregistre les données dans la variable "whale" et la fréquence d'échantillonnage dans "fe"
[whale,fe]=audioread("bluewhale.au"); 
%On définit un sous-signal "son" dans le signal "whale"
son = whale(2.45e4:3.10e4); 

%Question 2:

% On joue le sous-signal "son" à la fréquence d'échantillonnage "fe"
sound(son,fe)

%Question 3:

%définit le nombre d'échantillons (N) comme étant égal à la longueur du sous-signal "son"
N = length(son);
te = 1/fe;
t = (0:N-1)*(10*te);
figure;
subplot(2,1,1)
plot(t,son)
title('Le signal whant')

% On calcule la densité spectrale de puissance du sous-signal "son"
y = abs(fft(son)).^2/N; 

% On définit le vecteur fréquence (f) 
f = (0:floor(N/2))*(fe/N)/10;
subplot(2,1,2)
plot(f,y(1:floor(N/2)+1));
title('Le signal densité spectrale de puissance du signal')