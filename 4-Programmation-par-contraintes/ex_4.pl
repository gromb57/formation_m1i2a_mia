% Exercice 4 - Carré magique

% 1. Backtracking

:- use_module(library(lists)).

% calcule le carre magique de dimension N*N et renvoi le nombre magique dans R
% et le carré dans S, sous forme de matrice (liste de listes de longueur N).
carreMagique(N,R,S):-
    N2 is N*N,
    construit_liste(N2,LS),
    placerBT(N,R,LS,S).
%Construit une liste de N entiers
construit_liste(1,[1]):- !.
construit_liste(N,[N|L_Nb]):-
    N1 is N-1,
    construit_liste(N1,L_Nb).
% Prédicat placerBT(-N,+Ref,-Ls,+S)
% Place N*N nombres en vérifiant que la somme des lignes est égale à Ref ainsi
% que la somme des colonnes et des diagonales principales et renvoi le résultat dans S.
placerBT(N,Ref,LS,S):-
    placer_les_lignes(N,N,LS,[],S,Ref),
    tester_colonnes(N,S,Ref),
    test_diagonaleM(S,1,0,Ref),
    test_diagonaleD(S,N,0,Ref).

% Prédicat placer_les_lignes(-N,-Ls,+Acc,+S,+Ref)
% Place N lignes en prenant les nombres dans LS et renvoi le résultat dans S
% La partie de Backtracking qui cherche à placer les nombres tel que la somme
% des lignes correspond au même nombre Ref (le nombre magique).
placer_les_lignes(0,_,_,S,S,_Ref):-!.
placer_les_lignes(N,Nb,Ls,Acc,S,Ref):-
    placer_ligne(Nb,Ls,Lred,[],Lnew,Ref),
    N1 is N-1,
    placer_les_lignes(N1,Nb,Lred,[Lnew|Acc],S,Ref).
% placer_ligne(-Nb,-Ls,+Lred,-L,+Lnew,?Ref)
% On a Nb nombre à placer dans la ligne. On doit les prendre dans Ls et
% on retourne la liste Lred des nombres non encore utilisés.
% Si la somme est correct on construit une liste dans Lnew.
% Ainsi Place une ligne de nombre en vérifiant si leur somme est égale à Ref.
placer_ligne(0,LS,LS,L,L,R):-
    test_ligne(L,0,R),!.
placer_ligne(Nb,LS,Lred,L,Lnew,R):-
    select(Y,LS,LSred),
    Nb1 is Nb-1,
    placer_ligne(Nb1,LSred,Lred,[Y|L],Lnew,R).
% Prédicat tester_colonnes(N,M,Ref)
% Vérifie si pour les N colonnes de M la somme des éléments de chacun d'elle est égale à Ref.
tester_colonnes(0,_M,_Ref):-!.
tester_colonnes(I,M,Ref):-
    test_colonne(M,I,0,Ref),
    I1 is I-1,
    tester_colonnes(I1,M,Ref).
% Prédicat test_ligne(L,S,Ref)
% Vérifie si pour la ligne L la somme S de ses éléments est égale à Ref.
test_ligne([],S,S).
test_ligne([X|L],Som,Ref):-
    Som1 is Som+X,
    test_ligne(L,Som1,Ref).
% Prédicat test_ligne(M,I,S,Ref)
% Vérifie si pour la colonne I de M la somme S de ses élements est égale à Ref.
test_colonne([],_,S,S).
test_colonne([L|Lliste],I,Som,Ref):-
    nth1(I,L,X),
    Som1 is Som+X,
    test_colonne(Lliste,I,Som1,Ref).
% Prédicat test_diagonaleD(M,I,S,Ref)
% Vérifie si pour la diagonale négative de M la somme S de ses élément est égale à Ref.
test_diagonaleD([],_,S,S).
test_diagonaleD([L|Lliste],I,Som,Ref):-
    nth1(I,L,X),
    Som1 is Som+X,
    I1 is I-1,
    test_diagonaleD(Lliste,I1,Som1,Ref).
% Prédicat test_diagonaleM(M,I,S,Ref)
% Vérifie si pour la diagonale positive de M la somme S de ses éléments est égale à Ref.
test_diagonaleM([],_,S,S).
test_diagonaleM([L|Lliste],I,Som,Ref):-
    nth1(I,L,X),
    Som1 is Som+X,
    I1 is I+1,
    test_diagonaleM(Lliste,I1,Som1,Ref).

% 2. PLC
:- use_module(library(clpfd)).
:- use_module(library(lists)).

% calcul le carre magique de dimension N*N et renvoi le nombre magique dans R et
% le carré dans S, sous forme de matrice (liste de listes de longueur N).
magicSquare(N,R,S):-
    N2 is N*N,
    creer_Matrice(N,N,N2,L),
    constraintes_LC(N,L,L,R),
    constraintes_diagonales(N,L,R),
    recupere_Y(L,S),
    all_different(S), % all_different est un prédicat de la biblio clpfd qui dit ttes les
    labeling([],S).   % variables de la liste doivent avoir une valeur différente.
% Le prédicat creer_Matrice(I,N,N2,M)
% Creé une matrice M (liste de listes) de dimension N*N,
% soit N listes de longueur N, de variables ayant comme domaine l'intervalle [1,N2].
creer_Matrice(0,_,_,[]):-!.
creer_Matrice(I,N,N2,[L|M]):-
    creer_Ligne(N,N2,L),
    I1 is I-1,
    creer_Matrice(I1,N,N2,M).
% Le prédicat creer_Ligne(-I,-N,+L)
% Crééune liste L de I variables dont le domaine est compris entre 1 et N
creer_Ligne(0,_,[]):-!.
creer_Ligne(I,N2,[Y|L]):-
    Y in 1..N2,
    I1 is I-1,
    creer_Ligne(I1,N2,L).
% Pose les contraintes sur les lignes et les colonnes
constraintes_LC(0,_,_,_):- !.
constraintes_LC(I,[L|Lliste],M,R):-
    constraintes_ligne(L,0,R),
    constraintes_colonne(M,I,0,R),
    I1 is I-1,
    constraintes_LC(I1,Lliste,M,R).
% Pose les contraintes sur la somme des lignes
constraintes_ligne([],S,S).
constraintes_ligne([X|L],Som,Ref):-
    Som1 #= Som+X,
    constraintes_ligne(L,Som1,Ref).
% Pose les contraintes sur la somme des colonnes
constraintes_colonne([],_,S,S).
constraintes_colonne([L|Lliste],I,Som,Ref):-
    nth1(I,L,X), % nth1 prédicat de la biblio lists qui renvoie X, le Ieme élément de L
    Som1 #= Som+X,
    constraintes_colonne(Lliste,I,Som1,Ref).
% Pose les contraintes concernant les diagonales.
constraintes_diagonales(N,S,R):-
    constraintes_diagonaleD(S,N,0,R),constraintes_diagonaleM(S,1,0,R).
% le prédicat constraintes_diagonaleD(-L,-I,-Som,-Ref) pose les contraintes
% qui vérifient que la somme des éléments de la diagonale négative est égale à Ref.
% I est égal à 1 et Som à 0 au premier appel.
% Le cas terminal, une fois que l'on a sommé tous les éléments de la diagonale,
% vérifie que cette somme est égale à la somme déjà calculée.
constraintes_diagonaleD([],_,S,S).
constraintes_diagonaleD([L|Lliste],I,Som,Ref):-
    nth1(I,L,X),
    Som1 #= Som+X,
    I1 is I-1,
    constraintes_diagonaleD(Lliste,I1,Som1,Ref).
% le prédicat constraintes_diagonaleM(-L,-I,-Som,-Ref) pose les contraintes
% qui vérifient que la somme des éléments de la diagonale positive est égale à Ref.
% I est égal à 1 et Som à 0 au premier appel.
% Le cas terminal, une fois que l'on a sommé tous les éléments de la diagonale,
% vérifie que cette somme est égale à la somme déjà calculée.
constraintes_diagonaleM([],_,S,S).
constraintes_diagonaleM([L|Lliste],I,Som,Ref):-
    nth1(I,L,X),
    Som1 #= Som+X,
    I1 is I+1,
    constraintes_diagonaleM(Lliste,I1,Som1,Ref).
% Le prédicat recupere_y(-M,+L), met à plat la matrice (liste de listes) M en une liste L.
% On récupère la liste L des variables pour pouvoir faire le labeling
recupere_Y([],[]):- !.
recupere_Y([L|R],M):-
    recupere_Y(R,L1),
    append(L,L1,M). % le append est défini dans la librairie(list)
