:-module(chap3ex2, [ajout/3,contientEtatFinal/1,parcoursSuivant/3,etageSuivant/3,etatFinal/2,largeur/2]).
:-use_module("./ex_1.pl").
:-use_module(library(lists)).

% 1.
% PRE-REQUIS
% On ajoute une liste d'élément L1 entête d'une liste L2
% le résultat est donné dans L3
% La liste L1 est vide on recopie directement L2 dans L3
ajout([],L2,L2):- !.
% On privilégiera l'utilisation du prédicat append/3 de la bibliotheque lists.
% Cas général, on ajoute un élément X de L1 dans L3 en
% retour de l'appel récursif
ajout([X|L1],L2,[X|L3]):-
   ajout(L1,L2,L3).

% Identifier si le chemin a atteint l'arrivée
contientEtatFinal([A|_]):-
    arrivee(A).
% Prédicat calculant la liste des états suivants
% à partir d'un état initial
parcoursSuivant(X,N_PC,R):-
    deplace(X,Parcours),
    \+ member(Parcours,N_PC),
    parcoursSuivant(X,[Parcours|N_PC],R),!.
parcoursSuivant(_,R,R).
% On a traité tous les chemins de la liste
etageSuivant([],NV_L,NV_L):- !.
% On n'étend pas un chemin qui a déjà atteint l'arrivée
etageSuivant([X|L],NV_L,R):-
    contientEtatFinal(X),!,
    etageSuivant(L,NV_L,R).
% On récupère un chemin X pour lequel on calcule tous les déplacements,
% on le rajoute à la liste des chemins et on recommence
% avec les chemins restant L.
etageSuivant([X|L],NV_L,R):-
    parcoursSuivant(X,[],PC),
    ajout(PC,NV_L,NV_L1),
    etageSuivant(L,NV_L1,R).

% 2.
% On est dans l'état final, si le chemin R contient comme
% dernière case l'arrivée A
etatFinal([R|_],R) :-
    contientEtatFinal(R).
% Sinon on regarde les autres chemins
etatFinal([_|N_L],R) :-
    etatFinal(N_L,R).

% 3.
% Il n'y a plus aucun chemin a etendre
largeur([],_):- !, fail.
% Permet de tester si on a trouve une solution
largeur(N_L,R):-
    etatFinal(N_L,R).
% On etend la liste des chemins d'un pas
largeur(L,R):-
    etageSuivant(L,[],N_L),
    largeur(N_L,R).

% 4.
labyrinthe(R):-
    depart(C),
    largeur([[C]],R1),
    reverse(R1,R).