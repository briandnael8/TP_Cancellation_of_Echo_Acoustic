function [w, y, e] = algolms(x, d, P, mu)
    %Initialisation
    N = length(x);            
    w = zeros(P, 1);          
    y = zeros(N, 1);          
    e = zeros(N, 1);          

    for n = P:N

        % entrée
        x_vec = x(n:-1:n-P+1);

        % Calcul du signal de sortie
        y(n) = w' * x_vec;

        % Calcul de l'erreur
        e(n) = d(n) - y(n);

        % Mise à jour
        w = w + mu * e(n) * x_vec;
    end
end

