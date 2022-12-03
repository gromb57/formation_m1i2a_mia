% Exercice 1 - Crypto-arithmétique

% Soit le problème dont le but consiste à trouver les valeurs des 8 variables D,E,M,N,O,R,S et Y telles que :
%  — toutes ces variables soient des chiffres entre 0 et 9,
%  — toutes ces variables soient différentes,
%  — l’équation précédente soit vérifiée, ainsi M ̸= 0.

% Pré-requis :
:-use_module(library(lists)).

% 1. Avec la méthode du “Générer & Tester”

crypto1([D,E,M,N,O,R,S,Y]):-
    member(D,[0,1,2,3,4,5,6,7,8,9]),
    member(E,[0,1,2,3,4,5,6,7,8,9]),
    member(M,[0,1,2,3,4,5,6,7,8,9]),
    member(N,[0,1,2,3,4,5,6,7,8,9]),
    member(O,[0,1,2,3,4,5,6,7,8,9]),
    member(R,[0,1,2,3,4,5,6,7,8,9]),
    member(S,[0,1,2,3,4,5,6,7,8,9]),
    member(Y,[0,1,2,3,4,5,6,7,8,9]),
    dif(M,0),
    dif(D,E),dif(D,M),dif(D,N),dif(D,O),dif(D,R),dif(D,S),dif(D,Y),
    dif(E,M),dif(E,N),dif(E,O),dif(E,R),dif(E,S),dif(E,Y),
    dif(M,N),dif(M,O),dif(M,R),dif(M,S),dif(M,Y),
    dif(N,O),dif(N,R),dif(N,S),dif(N,Y),
    dif(O,R),dif(O,S),dif(O,Y),
    dif(R,S),dif(R,Y),
    dif(S,Y),
    Somme is (1000*(S+M))+(100*(E+O))+(10*(N+R))+(D+E),
    Somme is (10000*M)+(1000*O)+(100*N)+(10*E)+Y.

% Execution :
%?- crypto1(S).
%S = [7, 5, 1, 6, 0, 8, 9, 2] 

% 2. Avec la méthode de Backtracking

crypto2([D,E,M,N,O,R,S,Y]):-
    select(D,[0,1,2,3,4,5,6,7,8,9],Nv_Dom1),
    select(E,Nv_Dom1,Nv_Dom2),
    select(Y,Nv_Dom2,Nv_Dom3),
    calc_retenue(D,E,0,Y,Ret1),
    select(N,Nv_Dom3,Nv_Dom4),
    select(R,Nv_Dom4,Nv_Dom5),
    calc_retenue(N,R,Ret1,E,Ret2),
    select(O,Nv_Dom5,Nv_Dom6),
    calc_retenue(E,O,Ret2,N,Ret3),
    select(S,Nv_Dom6,Nv_Dom7),
    select(M,Nv_Dom7,_),
    calc_retenue(S,M,Ret3,O,M),
    dif(M,0).
calc_retenue(X,Y,Retenue,Somme,N_Retenue):-
    Add is X+Y+Retenue,
    Somme is mod(Add,10),
    N_Retenue is (Add-Somme)//10.
appartient_dif(X,[X|L],L).
appartient_dif(D,[X|L],[X|NL]):-
    appartient_dif(D,L,NL).

% Execution :
%?- crypto2(S).
%S = [7, 5, 1, 6, 0, 8, 9, 2] 

% 3. avec le paradigme de la programmation avec contraintes :

:- use_module(library(clpfd)).

send([S,E,N,D,M,O,R,Y],Type):-
    domaines(S,E,N,D,M,O,R,Y),
    contraintes(S,E,N,D,M,O,R,Y),
    somme(S,E,N,D,M,O,R,Y),
    labeling(Type,[S,E,N,D,M,O,R,Y]).
domaines(S,E,N,D,M,O,R,Y):-
    [S,E,N,D,M,O,R,Y] ins 0..9.
contraintes(S,E,N,D,M,O,R,Y):-
    M#>0,
    all_different([S,E,N,D,M,O,R,Y]).
somme(S,E,N,D,M,O,R,Y):-
    (1000*(S+M))+(100*(E+O))+(10*(N+R))+(D+E) #=
    (10000*M)+(1000*O)+(100*N)+(10*E)+Y.

% Execution :
% ?- send(S, []).
% S = [9, 5, 6, 7, 1, 0, 8, 2] ;
% false.

% 4. Donner une solution
% S=9, E=5, N=6, D=7, M=1, O=0, R=8, Y=2
