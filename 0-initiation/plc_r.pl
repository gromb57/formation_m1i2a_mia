:-use_module(library(clpr)).

% exemple de système d'équations
equation(X,Y):-{2*X = 3*Y + 5, X = Y -2}.

%?- equation(X,Y).
%X = -10.999999999999998,
%Y = -8.999999999999998.

% exemple de système d'équations
equation(X,Y,Z):-{2*X = 3*Y - Z + 5, X = Y -2}.

%?- equation(X,Y,Z).
%{Y=2.0+X, Z=11.0+X}.
