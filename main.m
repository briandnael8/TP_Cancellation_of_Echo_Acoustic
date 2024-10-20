%=========================================================================%
% TP1 Méthodes de Signal Avancées : Annulation d’Écho Acoustique
%=========================================================================%

% DE LA CHAISE - BRIAND

%================= I - IMPLEMENTATION DE L'ALGORITHME LMS ================%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

P = 4;
mu = 0.01;
N = 1000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I.2 : Génération des signaux test %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = randn(N, 1);
h = [1; 0.3; -0.1; 0.2];

d = filter(h, 1, x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I.4 - Validation de l'algorithme LMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calcule du filtre et du signal de sortie
[w, y, e] = algolms(x, d, P, mu);

%figure;
plot(1:N, d, 'b', 1:N, y, 'r', 1:N, e, 'g');
legend('Signal désiré d[n]', 'Signal de sortie y[n]', 'Erreur e[n]');
title('Comparaison des signaux');
xlabel('Temps (n)');
ylabel('Amplitude');

%figure;
plot(1:P, h, 'bo-', 1:P, w, 'rx-');
legend('Coefficients réels', 'Estimations LMS');
title('Comparaison des coefficients du filtre');
xlabel('Indice des coefficients');
ylabel('Valeur');

%figure;

% Signal désiré d[n]
subplot(3, 1, 1);
plot(d);
title('Signal désiré d[n]');
xlabel('Échantillons');
ylabel('Amplitude');
legend('d[n]');
grid on;

% Signal de sortie y[n]
subplot(3, 1, 2);
plot(y);
title('Signal de sortie y[n]');
xlabel('Échantillons');
ylabel('Amplitude');
legend('y[n]');
grid on;

% Erreur e[n]
subplot(3, 1, 3);
plot(e);
title('Erreur e[n]');
xlabel('Échantillons');
ylabel('Amplitude');
legend('e[n]');
grid on;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I.5 - Test de l algorithme LMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
noise = 0.1 * randn(1, N);
d_noisy = d + noise;

P_values = [5, 10, 20];
mu = 0.1;

%figure;
for i = 1:length(P_values)
    P = P_values(i);
    [w, y, e] = algolms(x, d_noisy, P, mu);

    % Tracé de l'erreur pour chaque P
    subplot(length(P_values), 1, i);
    plot(e);
    title(['Erreur e[n] pour P = ', num2str(P)]);
    xlabel('Échantillons');
    ylabel('Amplitude');
    legend('e[n]');
    grid on;
end

P = 5;
mu_values = [0.01,0.1,0.5];

%figure;
for i = 1:length(mu_values)
    mu = mu_values(i);
    [w, y, e] = algolms(x, d_noisy, P, mu);

    % Tracé de l'erreur pour chaque mu
    subplot(length(mu_values), 1, i);
    plot(e);
    title(['Erreur e[n] pour mu = ', num2str(mu)]);
    xlabel('Échantillons');
    ylabel('Amplitude');
    legend('e[n]');
    grid on;
end

%=========================== II - APPLICATION ============================%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% II.1 - Test de l algorithme LMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%On prend P et mu qui donne la meilleure convergence
P = 150;
mu = 0.01;

% Charger et écouter le signal audio
[y_audio, Fs] = audioread('Voix1.wav');
%sound(y_audio, Fs);
%pause(length(y_audio) / Fs);

% Charger la réponse impulsionnelle
Rep = importdata('Rep.dat');

filtered_signal = filter(Rep, 1, y_audio);
%sound(filtered_signal, Fs);
%pause(length(filtered_signal) / Fs);

% Ajouter bruit et annuler l'écho
noise = 0.1 * randn(size(filtered_signal));
noisy_signal = filtered_signal + noise;
%sound(noisy_signal, Fs);
%pause(length(noisy_signal) / Fs);

% Annuler l'écho
[w, y, e] = algolms(noisy_signal, y_audio, P, mu);
%sound(y, Fs)
%pause(length(y) / Fs);

% Signal après annulation d'écho
%figure;
subplot(3, 1, 1);
plot(y_audio);
title('Signal');
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal');
grid on;

subplot(3, 1, 2);
plot(noisy_signal);
title('Signal bruyant après ajout de bruit');
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal bruité');
grid on;

subplot(3, 1, 3);
plot(y);
title('Signal après annulation écho');
xlabel('Échantillons');
ylabel('Amplitude');
legend('Signal après annulation écho');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% II.2 - Signal audio avec deux voix %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[y_farspeech, Fs_farspeech] = audioread('s1.wav');
%sound(y_farspeech, Fs_farspeech);

[y_nearspeech, Fs_nearspeech] = audioread('s2.wav');
%sound(y_nearspeech, Fs_nearspeech);

% On filtre le signal éloigné avec la réponse impulsionnelle
Rep = importdata('Rep.dat');

filtered_farspeech_signal = filter(Rep, 1, y_farspeech);
%sound(filtered_farspeech_signal, Fs_farspeech);

dialogue_filtered = y_nearspeech(1:length(filtered_farspeech_signal)) + filtered_farspeech_signal(1:length(filtered_farspeech_signal));
%sound(dialogue_filtered, Fs_farspeech);

% Appliquer l'algorithme LMS 
[w, y_cleaned, e] = algolms(y_nearspeech, dialogue_filtered, 300, 0.001); 
sound(y_cleaned*5, Fs_nearspeech); 

% Comparer le signal original et le signal après annulation d'écho 
figure; 
subplot(3, 1, 1); 
plot(y_nearspeech); 
title('Signal proche'); 
xlabel('Échantillons'); 
ylabel('Amplitude'); 

subplot(3, 1, 2); 
plot(y_cleaned); 
title('Signal après annulation du signal loin avec echo'); 
xlabel('Échantillons'); 
ylabel('Amplitude');

