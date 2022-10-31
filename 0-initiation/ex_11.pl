% Nous sommes dans une agence matrimoniale qui possède un fichier de candidats au mariage organisé
% selon les trois catégories suivantes :
%
% 1. homme(N, T, C, A).
% femme(N, T, C, A).
%
% Où N est le nom d’une personne (d’un homme ou d’une femme),
% T sa taille (grande, moyenne, petite)
% C la couleur de ses cheveux (blonds, bruns, roux, châtains),
% A son âge (jeune, mûr, vieux).
%
% 2. gout(N, M, L, S).
% Indique que la personne N
% aime le genre de musique M (classique, pop, jazz)
% le genre de littérature L (aventure, science-fiction, policier)
% et pratique le sport S (tennis, natation, jogging).
%
% 3. recherche(N, T, C, A).
% Exprime que la personne N
% recherche un (une) partenaire de taille T ,
% ayant des cheveux de couleur C,
% et dont l’âge est A.

% On considère que deux personnes X et Y de sexe différent sont assorties si X convient à Y et si Y convient à X .
% On dira que X convient à Y si d’une part, X convient physiquement à Y (taille, age, couleur de cheveux)
% et si d’autre part, les goûts de X et Y en matière de musique, littérature et sport sont identiques.

% Questions
% 1. Donner un ensemble d’assertions présentant le fichier des candidats.

homme(Luc, g, bl, m).
homme(Gaston, m, bl, m).
homme(Kevin, g, br, j).
homme(Remi, m, bl, v).

femme(Martine, p, bl, m).
femme(Odile, m, bl, j).
femme(Lea, p, br, m).
femme(Elsa, g, br, j).
femme(Sylvie, m, bl, j).
femme(Julie, p, bl, m).
femme(Mathilde, g, bl, m).
femme(Anne, g, bl, v).

gout(Luc, pop, policier, tennis).
gout(Gaston, classique, aventure, natation).
gout(Kevin, jazz, sf, jogging).
gout(Remi, classique, aventure, jogging).
gout(Martine, classique, aventure, natation).
gout(Odile, classique, sf, natation).
gout(Lea, classique, policier, tennis).
gout(Elsa, jazz, sf, jogging).
gout(Sylvie, classique, sf, natation).
gout(Julie, pop, policier, tennis).
gout(Mathilde, classique, policier, tennis).
gout(Anne, classique, aventure, tennis).

recherche(Luc, m, r, [j,m]).
recherche(Gaston, p, bl, [j,m]).
recherche(Kevin, m, r, j).
recherche(Remi, p, bl, m).
recherche(Martine, m, bl, [m,v]).
recherche(Odile, g, br, j).
recherche(Lea, m, br, [m,v]).
recherche(Elsa, g, [br,r], m).
recherche(Sylvie, g, indif, m).
recherche(Julie, [p,m], r, j).
recherche(Mathilde, g, br, [m,v]).
recherche(Anne, g, [br,bl], v).

% 2. Ecrire les règles définissant convient_physiquement(X, Y),
% ensuite les règles définissant ont_memes_gouts(X, Y).(Application avec X=martine)

convient_physiquement(X, Y) :-
    homme(X, _, _, _),
    recherche(Y, T, C, A),
    femme(Y, T, C, A).
convient_physiquement(X, Y) :-
    femme(X, _, _, _),
    recherche(Y, T, C, A),
    homme(Y, T, C, A).

ont_memes_gouts(X, Y) :-
    homme(X, _, _, _),
    femme(Y, _, _, _),
    gout(X, M, L, S),
    gout(Y, M, L, S).

ont_memes_gouts(X, Y) :-
    femme(X, _, _, _),
    homme(Y, _, _, _),
    gout(X, M, L, S),
    gout(Y, M, L, S).

% 3. En déduire le programme qui détermine les couples assortis.

assorti(X, Y) :-
    convient_physiquement(X, Y),
    convient_physiquement(Y, X),
    ont_memes_gouts(X, Y).

% 4. Etudier les simplifications que l’on pourrait avoir si convient_physiquement(X, Y) était symétrique.

% pour ne pas avoir les résultats en double :
assortis(X, Y):-
    convient_physiquement(X, Y),
    ont_memes_gouts(X, Y),!.
assortis(X, Y):-
    convient_physiquement(Y, X),
    ont_memes_gouts(X, Y).
