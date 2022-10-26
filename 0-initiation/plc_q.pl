:-use_module(library(clpq)).

% exemple de système d'équations
equation(X,Y):-{2*X = 3*Y + 5, X = Y -2}.

%?- equation(X,Y).
%X = -11,
%Y = -9.

% exemple de système d'équations
equation(X,Y,Z):-{2*X = 3*Y - Z + 5, X = Y -2}.

%?- equation(X,Y,Z).
%{Y=2+X, Z=11+X}.