:-module(chap3ex1, [frontiere/2,depart/1,arrivee/1,deplacementCorrect/2,deplace/2]).
:-use_module(library(lists)).

% 1.

frontiere([1,1], [1,2]).
frontiere([3,1], [3,2]).
frontiere([4,1], [4,2]).
frontiere([1,2], [2,2]).
frontiere([2,2], [3,2]).
frontiere([3,2], [3,3]).
frontiere([5,2], [5,3]).
frontiere([1,3], [2,3]).
frontiere([3,3], [4,3]).
frontiere([3,3], [3,4]).
frontiere([5,3], [5,4]).
frontiere([1,4], [1,5]).
frontiere([2,4], [3,4]).
frontiere([3,4], [3,5]).
frontiere([4,4], [4,5]).

depart([1,1]).
arrivee([5,5]).

% 2.
caseCorrecte([X,Y]) :- X >= 1, X =< 5, Y >= 1, Y =< 5.

% 3.
deplacementCorrect([X1,Y1], [X2,Y2]) :-
    caseCorrecte([X1,Y1]),
    caseCorrecte([X2,Y2]),
    \+ frontiere([X1,Y1], [X2,Y2]).

% 4.
% à droite
deplace([C1|Parcours], [C2,C1|Parcours]) :-
    C1 = [X1,Y1],
    X2 is X1 + 1,
    C2 = [X2,Y1],
    deplacementCorrect(C1, C2),
    \+ member(C2, Parcours).
% à gauche
deplace([C1|Parcours], [C2,C1|Parcours]) :-
    C1 = [X1,Y1],
    X2 is X1 - 1,
    C2 = [X2,Y1],
    deplacementCorrect(C1, C2),
    \+ member(C2, Parcours).
% en bas
deplace([C1|Parcours], [C2,C1|Parcours]) :-
    C1 = [X1,Y1],
    Y2 is Y1 + 1,
    C2 = [X1,Y2],
    deplacementCorrect(C1, C2),
    \+ member(C2, Parcours).
% en haut
deplace([C1|Parcours], [C2,C1|Parcours]) :-
    C1 = [X1,Y1],
    Y2 is Y1 - 1,
    C2 = [X1,Y2],
    deplacementCorrect(C1, C2),
    \+ member(C2, Parcours).

% 5.
parcours([C|Parcours],[C|Parcours]):-
    arrivee(C),!.

parcours(Parcours,Solution):-
    deplace(Parcours,Suivant),
    parcours(Suivant,Solution).

% 6.
labyrinthe(Solution) :-
    depart(C),
    parcours([C], Sol),
    reverse(Sol,Solution).

