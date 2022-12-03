% Exercice 3 - Les amazones

:- use_module(library(lists)).

%Construit une liste de N entiers
construit_liste(1,[1]):- !.
construit_liste(N,[N|L_Nb]):-
    N1 is N-1,
    construit_liste(N1,L_Nb).

% 1. Générer & Tester

amazonesGT(N,R):-
    construit_liste(N,L_Nb),
    placerGT(N,L_Nb,[],R),
    test_nen_priseGT(R).
placerGT(0,_,R,R):- !.
placerGT(Nb,L_Nb,L,R):-
    select(Y,L_Nb,L_Nb1),
    Nb1 is Nb-1,
    placerGT(Nb1,L_Nb1,[[Nb,Y]|L],R).
test_nen_priseGT([]).
test_nen_priseGT([C1|R]):-
    non_en_priseRGT(R,C1),
    non_en_priseCGT(R,C1),
    test_nen_priseGT(R).
% Regarde si une case (2eme argument) est en prise avec un des
% éléments de la liste (1er argument).
non_en_priseRGT([],_).
non_en_priseRGT([[X1,Y1]|R],[X,Y]):-
    X =\= X1, % Colonne
Y =\= Y1, % Ligne
abs(X-X1) =\= abs(Y-Y1), % Diagonale
    non_en_priseRGT(R,[X,Y]).
non_en_priseCGT([],_).
non_en_priseCGT([[X1,Y1]|L],[X,Y]):-
    3 =\= abs(Y-Y1)+abs(X-X1),
    non_en_priseCGT(L,[X,Y]).

% Execution :
% ?- amazonesGT(N,R).
% N = 1,
% R = [[1, 1]].
% 
% ?- amazonesGT(2,R).
% false.
% 
% ?- amazonesGT(4,R).
% false.
% 
% ?- amazonesGT(10,R).
% R = [[1, 3], [2, 6], [3, 9], [4, 1], [5, 4], [6, 7], [7, 10], [8|...], [...|...]|...] ;
% R = [[1, 4], [2, 8], [3, 1], [4, 5], [5, 9], [6, 2], [7, 6], [8|...], [...|...]|...] ;
% R = [[1, 7], [2, 3], [3, 10], [4, 6], [5, 2], [6, 9], [7, 5], [8|...], [...|...]|...] .

% 2. Backtracking

amazonesBT(N,R):-
    construit_liste(N,L_Nb),
    placerBT(N,L_Nb,[],R).
placerBT(0,_,R,R):- !.
placerBT(Nb,L_Nb,L,R):-
    select(Y,L_Nb,L_Nb1),
    non_en_priseRGT(L,[Nb,Y]),
    non_en_priseCGT(L,[Nb,Y]),
    Nb1 is Nb-1,
    placerBT(Nb1,L_Nb1,[[Nb,Y]|L],R).

% Execution :
% ?- amazonesBT(10, R).
% R = [[1, 3], [2, 6], [3, 9], [4, 1], [5, 4], [6, 7], [7, 10], [8|...], [...|...]|...] ;
% R = [[1, 4], [2, 8], [3, 1], [4, 5], [5, 9], [6, 2], [7, 6], [8|...], [...|...]|...] ;
% R = [[1, 7], [2, 3], [3, 10], [4, 6], [5, 2], [6, 9], [7, 5], [8|...], [...|...]|...] ;
% R = [[1, 8], [2, 5], [3, 2], [4, 10], [5, 7], [6, 4], [7, 1], [8|...], [...|...]|...] ;
% false.

% 3. programmation avec contrainte.

:-use_module(library(clpfd)).

amazonesPLC(N,Type,Sol):-
   length(LV,N),
   LV ins 1..N,
   all_different(LV),
   contraintes_amazones(N,LV,Los),
   labeling(Type,LV),
   %% on peut faire un reverse pour avoir la liste comme les autres
   reverse(Los,Sol).

contraintes_amazones(0,_,[]):-!.
contraintes_amazones(I,[Y|LV],[[I,Y]|R]):-
    I1 is I-1,
    contraintes_amazones(I1,LV,R),
    contraintes_reine(R,[I,Y]),
    contraintes_cavalier(R,[I,Y]).
contraintes_reine([],_):- !.
contraintes_reine([[X1,Y1]|L],[X,Y]):-
    abs(X1-X) #\= abs(Y1-Y),% inutile de vérifier X1\=X et Y1\=Y
    contraintes_reine(L,[X,Y]).
contraintes_cavalier([],_).
contraintes_cavalier([[X1,Y1]|R],[X,Y]):-
    3 #\= abs(Y-Y1)+abs(X-X1),
    contraintes_cavalier(R,[X,Y]).

% Execution :
% ?- amazonesPLC(10, [], Sol).
% Sol = [[1, 8], [2, 5], [3, 2], [4, 10], [5, 7], [6, 4], [7, 1], [8|...], [...|...]|...] ;
% Sol = [[1, 7], [2, 3], [3, 10], [4, 6], [5, 2], [6, 9], [7, 5], [8|...], [...|...]|...] ;
% Sol = [[1, 4], [2, 8], [3, 1], [4, 5], [5, 9], [6, 2], [7, 6], [8|...], [...|...]|...] ;
% Sol = [[1, 3], [2, 6], [3, 9], [4, 1], [5, 4], [6, 7], [7, 10], [8|...], [...|...]|...] ;
% false.

% 4. Question 4 : Comparaison des résultats :
% Algorithme | nombre de solutions  | Backtracking | Contrainte
% _____________________________________________________________
%  10        |      4               |  0.200s      |  0.000s
%  12        |      156             |  2.600s      |  0.600s
%  14        |      5180            |  105s        |  1.200s
%  16        |      202900          |  5702s       |  486s
