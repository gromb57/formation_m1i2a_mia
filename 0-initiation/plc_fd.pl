:- use_module(library(clpfd)).

% Declaration par variable
%X in 0..8, Y in 0..8.

% Declaration liste de variables
%[X,Y] ins 0..8.

% le domaine est discontinu
%Z in {0,1,2,3,6,8}.
%Z in {0,1,2,3}\/{6,8}.
%Z in {0,1,2,3}\/{6}\/{8}.
%Z in (0..3) \/ {6,8}.
%Z in 0..3 \/ 6 \/ 8.

domain(L,Bmin,BMax):- L ins Bmin..Bmax.

%equation(X,Y,Z):-
%    [X,Y,Z] ins 0..5, % pose des domaines
%    X #= Y+5, % pose
%    X #\= 2*Y, % des
%    X #> Y+Z. % contraintes

%?- equation(X,Y,Z).
%X = 5,
%Y = 0,
%Z in 0..4.

equation(X,Y,Z):-
    [X,Y,Z] ins 0..5, % pose des domaines
    X #= Y+5, % pose
    X #\= 2*Y, % des
    X #> Y+Z, % contraintes
    labeling([],[X,Y,Z]).% génération de valeurs avec
                         % options par défaut

%?- equation(X,Y,Z).
%X = 5,
%Y = Z, Z = 0 .

%X = 5,
%Y = 0,
%Z = 1 ;

%X = 5,
%Y = 0,
%Z = 2 ;

%X = 5,
%Y = 0,
%Z = 3 ;

%X = 5,
%Y = 0,
%Z = 4.
