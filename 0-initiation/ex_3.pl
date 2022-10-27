% Définir ajout_debut(X,L,R) ayant la signification : ’R est obtenue en ajoutant X au dé- but de la liste L’.
% La réponse à la question ajout_debut(9,[2,4,6],R). sera R=[9,2,4,6] (une clause suffit).
ajout_debut(X,L,R) :-
    R=[X|L].