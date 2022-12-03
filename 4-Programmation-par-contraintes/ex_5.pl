% Exercice 5 - Graphe de nombres

% 1. Backtracking

% On code le prédicat solution
solution([A,B,C,D,E,F,G,H,I]):-
    % On effectue le traitement ligne par ligne
    % ligne entre A et B
    select(A,[2,3,4,5,6,7,8,9,10,11,12],LA),
    select(B,LA,LB),
    20 is A + B,
    % Ligne entre A, D et G
    select(D,LB,LD),
    select(G,LD,LG),
    20 is A+D+G,
    % Ligne entre B, E et H
    select(E,LG,LE),
    select(H,LE,LH),
    20 is B+E+H,
    % Lignes entre G, H et I et A, E et I
    select(I,LH,LI),
    20 is G+H+I,
    20 is A+E+I,
    % Dernière ligne entre C, D, E et F
    select(C,LI,LC),
    select(F,LC,_),
    20 is C+D+E+F.

% Execiton :
% ?- solution(S).
% S = [8, 12, 4, 2, 5, 9, 10, 3, 7] ;
% S = [8, 12, 9, 2, 5, 4, 10, 3, 7] ;
% S = [12, 8, 4, 2, 3, 11, 6, 9, 5] ;
% S = [12, 8, 11, 2, 3, 4, 6, 9, 5] ;
% false.

% 2. PLC

% L'utilisation de la plc se fait au travers de la librairie CLP(FD)
:-use_module(library(clpfd)).
%Defintion du prédication solution_clp
solution_clp( [A,B,C,D,E,F,G,H,I]):-
    % Définition du domaine pour chaque noeud
    domains([A,B,C,D,E,F,G,H,I],2,12),
    % Chaque noeud possède une valeur différente
    all_different([A,B,C,D,E,F,G,H,I]),
    % Définition de chacune des lignes
    A+B #= 20,
    A+D+G #= 20,
    B+E+H #= 20,
    G+H+I #= 20,
    A+E+I #= 20,
    C+D+E+F #= 20,
    % Recherche des solutions
    labeling([],[A,B,C,D,E,F,G,H,I]).
domains(L,Min,Max):-
    L ins Min..Max.

% Execution :
% ?- solution_clp(S).
% S = [8, 12, 4, 2, 5, 9, 10, 3, 7] ;
% S = [8, 12, 9, 2, 5, 4, 10, 3, 7] ;
% S = [12, 8, 4, 2, 3, 11, 6, 9, 5] ;
% S = [12, 8, 11, 2, 3, 4, 6, 9, 5] ;
% false.

% 3. Solution

% — pour le backtracking, il suffit de partir avec la liste [2,3,4,5,7,8,9,10,12]
% — pour la plc, on peut changer le prédicat domains :
%         domains(L,T):-
%             L ins T.
% avec comme appel:domains([A,B,C,D,E,F,G,H,I],(2..5) \/ (7..10) \/ {12}),
% — On a deux solutions :
% (a) L = [8,12,4,2,5,9,10,3,7] (b) L = [8,12,9,2,5,4,10,3,7]