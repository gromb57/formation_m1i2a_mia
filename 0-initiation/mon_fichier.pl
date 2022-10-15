% liste de faits d'un programme PROLOG
habite(laurent,vesoul).
habite(fabrice,marseille).
habite(fabien,belfort).
habite(christophe,vesoul).

%?- habite(fabrice,marseille).
%true.

%?- habite(fabien,X).
%X = belfort.

%?- habite(X,vesoul).
%X = christophe .

%?- habite(X,vesoul).
%X = christophe .

%?- habite(X,vesoul).
%X = christophe ;
%X = laurent.

%?- habite(X,X).
%false.

% Pour chercher les individus habitant au même endroit :
%?- habite(X,V),habite(Y,V).
%X = Y, Y = christophe,
%V = vesoul ;
%X = christophe,
%V = vesoul,
%Y = laurent ;
%X = Y, Y = fabrice,
%V = marseille ;
%X = Y, Y = fabien,
%V = belfort ;
%X = laurent,
%V = vesoul,
%Y = christophe ;
%X = Y, Y = laurent,
%V = vesoul.

% règle PROLOG
meme_endroit(X,Y):- habite(X,V),habite(Y,V).

%...

% les listes
%?- [a, b] = [X | Y].
%X = a,
%Y = [b].

%?- [a] = [X | Y].
%X = a,
%Y = [].

%?- [a, [b]] = [X | Y].
%X = a,
%Y = [[b]].

%?- [a, b, c, d] = [X, Y | Z].
%X = a,
%Y = b,
%Z = [c, d].

%?- [[a, b, c], d, e] = [X | Y].
%X = [a, b, c],
%Y = [d, e].

% Exemple : appartient(X,L) : X appartient à L
appartient(X,[X|_Y]).
appartient(X,[_Z|Y]):- appartient(X,Y).

%[trace]  ?- appartient(X,[a,b,c]).
%   Call: (10) appartient(_17554, [a, b, c]) ? creep
%   Exit: (10) appartient(a, [a, b, c]) ? creep
%X = a ;

% Exemple : intersection(L1,L2,R) :
% R est l'intersection de L1 et L2
intersection([], _, []).
intersection([X|L1], L2, [X|R1]) :-
             appartient(X, L2),
             !,
             intersection(L1, L2, R1).
intersection([_|L1], L2, R) :-
             intersection(L1, L2, R).

%?- intersection([a,b,c],[d,b,e,a],R).
%R = [a, b] ;
%R = [a] ;
%R = [b] ;
%R = [].

% L’opérateur numérique "is"
%?- X=1+2.
%X = 1+2.

%?- X is 1+2.
%X = 3.

%?- Y=1, X is Y+2.
%Y = 1,
%X = 3.

% Comparaison de valeurs numériques
%?- X=2, Y=1, X>=Y.
%X = 2,
%Y = 1.

%?- X=2, Y=1, X=<Y.
%false.
