% Exercice 1

% 1.

%Calcul tous les coups possibles à partir d'une position donnée pour le joueur A (max),
%il créé la liste des fils en position une valeur 1 à la place d'un 0 pour chaque fils
successeurs(max(Position),Children) :-
    setof([A,B,C,D,E,F,G,H,I],succ(max(Position),[A,B,C,D,E,F,G,H,I]),Children).
%Calcul tous les coups possibles à partir d'une position donnée pour le joueur B (min),
%il créé la liste des fils en position une valeur 2 à la place d'un 0 pour chaque fils
successeurs(min(Position),Children) :-
    setof([A,B,C,D,E,F,G,H,I],succ(min(Position),[A,B,C,D,E,F,G,H,I]),Children).
%Transforme une case vide (0) en case jouée par le joueur A (1). Ce prédicat
%effectue tous les cas possibles (il y aura autant de points de choix que
%de 0 restant dans la liste).
succ(max([0|X]),[1|X]).
succ(max([A|X]),[A|Y]) :-
    succ(max(X),Y).
%Transforme une case vide (0) en case jouée par le joueur B(2). Ce prédicat
%effectue tous les cas possibles (il y aura autant de points de choix que
%de 0 restant dans la liste).
succ(min([0|X]),[2|X]).
succ(min([A|X]),[A|Y]) :-
    succ(min(X),Y).

% 2.

% Ce prédicat permet de savoir si la configuration correspond à un coup qui peut être gagnant.
gain_possible_max(A,B,C) :-
    A\=2,B\=2,C\=2. % A peut gagner avec cette ligne si B n'a pas joué de coup dessus
gain_possible_min(A,B,C) :-
    A\=1,B\=1,C\=1. % B peut gagner avec cette ligne si A n'a pas joué de coup dessus
%Si les deux joueurs peuvent finir avec la ligne (aucun des deux n'y a joué)
gain_possible(A,B,C,0) :-
    gain_possible_max(A,B,C),
    gain_possible_min(A,B,C),!.
% Si A peut finir la ligne, on compte 1
gain_possible(A,B,C,1) :-
    gain_possible_max(A,B,C),!.
% Si B peut finir la ligne, on compte -1
gain_possible(A,B,C,-1) :-
    gain_possible_min(A,B,C),!.
% Si aucun des cas précédents n'est possible, la ligne a été joué par les deux
gain_possible(_,_,_,0).

% 3.

% le prédicat p donne les combinaisons des lignes gagnantes
p([X,X,X,_,_,_,_,_,_],X).
p([_,_,_,X,X,X,_,_,_],X).
p([_,_,_,_,_,_,X,X,X],X).
p([X,_,_,X,_,_,X,_,_],X).
p([_,X,_,_,X,_,_,X,_],X).
p([_,_,X,_,_,X,_,_,X],X).
p([X,_,_,_,X,_,_,_,X],X).
p([_,_,X,_,X,_,X,_,_],X).
%Calcul de l'heuristique
h([A1,B1,C1,A2,B2,C2,A3,B3,C3],999) :-
    p([A1,B1,C1,A2,B2,C2,A3,B3,C3],1). % On a une ligne complète pour A
h([A1,B1,C1,A2,B2,C2,A3,B3,C3],-999) :-
    p([A1,B1,C1,A2,B2,C2,A3,B3,C3],2). % On a une ligne complète pour B
% Cas général de l'heuristique, on va évaluer le coût de chaque ligne et
%sommet le résultat pour avoir la valeur renvoyé par l'heuristique
h([A1,B1,C1,A2,B2,C2,A3,B3,C3],Valeur) :-
    gain_possible(A1,B1,C1,A),
    gain_possible(A2,B2,C2,B),
    gain_possible(A3,B3,C3,C),
    gain_possible(A1,A2,A3,D),
    gain_possible(B1,B2,B3,E),
    gain_possible(C1,C2,C3,F),
    gain_possible(A1,B2,C3,G),
    gain_possible(A3,B2,C1,H),
    sum([A,B,C,D,E,F,G,H],Valeur).
% Prédicat permettant d'effectuer la somme des éléments d'une liste
sum([],0).
sum([X|Y],R):-
    sum(Y,R1),
    R is X + R1.

% 4.

%Le joueur A a gagné si on a une position 999 (cf. heuristique)
gagnant(Position,999):-
    h(Position,999),!.
%Le joueur B a gagné si on a une position -999 (cf. heuristique)
gagnant(Position,-999):-
    h(Position,-999).

% 5.

%Permet de choisir le fils ayant le meilleur résultat (heuristique) et
% renvoie le coût Alpha et le chemin correspondant.
% max_children(-Liste,-Alpha,-Beta,+Val,+Path,-Profondeur)
% Liste : La liste des fils d'un noeud
% Alpha : le coefficient Alpha courant
% Beta : le coefficient Beta courant
% Val : la meilleur valeur obtenue
% Path : Le meilleur chemin développé pour la profondeur considérée
% Profondeur : La profondeur de l'arbre de recherche.
max_children([], Alpha, _, Alpha, [], _):-!.
max_children([Child|Children], Alpha, Beta, Val, Path, Profondeur2):-
    alphaBeta(min(Child), Alpha, Beta, Val1, Path0, Profondeur2),
    Alpha1 is max(Alpha, Val1),
    (Alpha1<Beta) ->
        max_children(Children, Alpha1, Beta, Val2, Path2, Profondeur2),
        compare(max, Alpha1, Val2, Path0, Path2, Val, Path)
    ;
        Val is Beta,
        Path = Path0
    ).
min_children([], _, Beta, Beta, [], _):-!.
min_children([Child|Children], Alpha, Beta, Val, Path, Profondeur2):-
    alphaBeta(max(Child), Alpha, Beta, Val1, Path0, Profondeur2),
    Beta1 is min(Beta, Val1),
    (
    (Alpha<Beta1) ->
        min_children(Children, Alpha, Beta1, Val2, Path2, Profondeur2),
        compare(min, Beta1, Val2, Path0, Path2, Val, Path)
    ;
        Val is Alpha,
    Path = Path0
    ).
compare(max,V1,V2,P1,_,V1,P1):-
    V1 >= V2,!.
compare(min,V1,V2,P1,_,V1,P1):-
    V1 =< V2,!.
compare(_,_,V2,_,P2,V2,P2).

% 6.

% alphaBeta(-f(Position),-Alpha, -Beta, +Val, +Path, -Profondeur)
   % max_children(-Liste,-Alpha,-Beta,+Val,+Path,-Profondeur)
   % f(Position) : f indiquant le joueur (max ou min) Position est le
   %plateau de jeu courant
   % Alpha : le coefficient Alpha courant
   % Beta : le coefficient Beta courant
   % Val : la meilleur valeur obtenue
   % Path : Le meilleur chemin développé pour la profondeur considérée
   % Profondeur : La profondeur de l'arbre de recherche.
   % Pour le dernier coup, on calcule la valeur avec l'heuristique
   alphaBeta(max(Position), _, _, Val, [Position], 0):-
    h(Position, Val),!.
alphaBeta(min(Position), _, _, Val, [Position], 0):-
    h(Position, Val),!.
%On regarde si on a un coup gagnant (une ligne a été réalisé)
alphaBeta(max(Position), _, _, Val, [Position], _):-
    gagnant(Position, Val),!.
alphaBeta(min(Position), _, _, Val, [Position], _):-
    gagnant(Position, Val),!.
% Cas d'arret de l'algorithme AlphaBeta où Alpha >= Beta
alphaBeta(max(Position),Alpha, Beta, Val, [Position], _):-
    Alpha >= Beta,
    Val is Beta,!.
alphaBeta(min(Position), Alpha, Beta, Val, [Position], _):-
    Alpha >= Beta,
    Val is Alpha,!.
% Cas général, on calcule pour une profondeur tous les fils puis on
% cherche le meilleur avec l'algorithme AlphaBeta.

alphaBeta(max(Position), Alpha, Beta, Val, [Position|Path], Profondeur):-
    successeurs(max(Position), Children),
    Profondeur2 is Profondeur-1,
    max_children(Children, Alpha, Beta, Val, Path, Profondeur2).
alphaBeta(min(Position), Alpha, Beta, Val, [Position|Path], Profondeur):-
    successeurs(min(Position), Children),
    Profondeur2 is Profondeur-1,
    min_children(Children, Alpha, Beta, Val, Path, Profondeur2).

% 7.

%On peut pour simplifier l'appel créer un prédicat prenant les valeurs
   %par défaut de Alpha et Beta et limitant la profondeur au nombre de
   %coup possible restant :
ab(max(Position), S, Profondeur):-
    compte0(Position,L),
    P is min(L,Profondeur),
    alphaBeta(max(Position), -999, 999, _, S, P).
ab(min(Position), S, Profondeur):-
    compte0(Position,L),
    P is min(L,Profondeur),
    alphaBeta(min(Position), -999, 999, _, S, P).
compte0([],0).
compte0([X|L],N):-
    compte0(L,N1),
    ((X=0) -> ValX is 1; ValX is 0),
    N is N1 + ValX.