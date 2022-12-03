% Exercice 2 - Les reines

:- use_module(library(lists)).

% 1. Générer & Tester

reines(N,R):-
    construit_liste(N,L_Nb),
    placer1(N,L_Nb,[],R),
    test_nen_prise1(R).
%Construit une liste de N entiers
construit_liste(1,[1]):- !.
construit_liste(N,[N|L_Nb]):-
    N1 is N-1,
    construit_liste(N1,L_Nb).
% Construit toutes les permutations en mettant une liste candidate
% dans le 4eme argument
placer1(0,_,R,R):- !.
placer1(N,L_Nb,L,R):-
    member(Y,L_Nb),
    N1 is N-1,
    placer1(N1,L_Nb,[[N,Y]|L],R).
%Regarde si la liste contient des reines en prises
test_nen_prise1([]).
test_nen_prise1([C1|R]):-
    test_nen_prise11(R,C1),
    test_nen_prise1(R).
% Regarde si une case (2eme argument) est en prise avec un des
% éléments de la liste (1er argument).
test_nen_prise11([],_).
test_nen_prise11([[X1,Y1]|R],[X,Y]):-
    X =\= X1, % Colonne
Y =\= Y1, % Ligne
abs(X-X1) =\= abs(Y-Y1), % Diagonale
    test_nen_prise11(R,[X,Y]).

% Execution :
% ?- reines(N, R).
% N = 1,
% R = [[1, 1]].

% 2. Backtracking
reinesBT(N,R):-
    construit_liste(N,L_Nb),
    placer2(N,L_Nb,[],R).
placer2(0,_,R,R):-!.
placer2(Nb,L_Nb,L,R):-
    select(Y,L_Nb,L_Nb1),
    test_nen_prise11(L,[Nb,Y]),
    Nb1 is Nb-1,
    placer2(Nb1,L_Nb1,[[Nb,Y]|L],R).

% Execution :
% ?- reinesBT(N,R).
% N = 1,
% R = [[1, 1]].

% 3. programmation avec contrainte.

:- use_module(library(clpfd)).

reinesPLC(N,Type,Sol):-
length(LV,N),
LV ins 1..N,
all_different(LV),
    constraint(N,LV,Los),
    labeling(Type,LV),
    %% on peut faire un reverse pour avoir la liste comme les autres
    reverse(Los,Sol).
constraint(0,_,[]):- !.
constraint(I,[Y|LV],[[I,Y]|R]):-
    I1 is I-1,
    constraint(I1,LV,R),
    constraint_one([I,Y],R).
constraint_one(_,[]):- !.
constraint_one([A,B],[[C,D]|L]):-
    A #\= C, % inutile par construction du prédicat constraint
    B #\= D, % inutile avec le all_different
    abs(A-C) #\= abs(B-D),
    constraint_one([A,B],L).

% 4. Comparez les temps d’exécution pour les reines 4 (2 solutions sans permutations), 6 (4
% solutions), 8 (92 solutions), 10 (sans générer /tester, 724 solutions) et 12 (14200 solutions).
% Pour cela, on utilisera statistics,findall(R,reines(4,R),T),length(T,L),statistics.

% Execution :
% statistics,findall(R,reines(4,R),T),length(T,L),statistics.

% Started at Sat Dec  3 19:05:09 2022
% 0.441 seconds cpu time for 1,777,481 inferences
% 7,000 atoms, 5,561 functors, 4,141 predicates, 59 modules, 226,107 VM-codes
% 
%                     Limit   Allocated      In use
% Local  stack:           -      116 Kb    2,336  b
% Global stack:           -      512 Kb      305 Kb
% Trail  stack:           -      130 Kb    1,200  b
%        Total:    1,024 Mb      758 Kb      309 Kb
% 
% 7 garbage collections gained 1,222,856 bytes in 0.002 seconds.
% 8 atom garbage collections gained 2,531 atoms in 0.003 seconds.
% 12 clause garbage collections gained 278 clauses in 0.000 seconds.
% Stack shifts: 3 local, 8 global, 15 trail in 0.001 seconds
% 2 threads, 0 finished threads used 0.000 seconds
% Started at Sat Dec  3 19:05:09 2022
% 0.442 seconds cpu time for 1,780,848 inferences
% 7,002 atoms, 5,561 functors, 4,134 predicates, 59 modules, 226,107 VM-codes
% 
%                     Limit   Allocated      In use
% Local  stack:           -      116 Kb    2,008  b
% Global stack:           -      512 Kb      319 Kb
% Trail  stack:           -      130 Kb    2,080  b
%        Total:    1,024 Mb      758 Kb      323 Kb
% 
% 7 garbage collections gained 1,222,856 bytes in 0.002 seconds.
% 8 atom garbage collections gained 2,531 atoms in 0.003 seconds.
% 12 clause garbage collections gained 278 clauses in 0.000 seconds.
% Stack shifts: 3 local, 8 global, 15 trail in 0.001 seconds
% 2 threads, 0 finished threads used 0.000 seconds
% T = [[[1, 2], [2, 4], [3, 1], [4, 3]], [[1, 3], [2, 1], [3, 4], [4, 2]]],
% L = 2.
