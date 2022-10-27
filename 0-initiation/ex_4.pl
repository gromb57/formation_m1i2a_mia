% La bilbliothèque de test unitaire
%:-use_module(library(plunit)).

% Définir ajout_fin(X,L,R) ayant la signification : ’R est obtenue en ajoutant X à la fin de la liste L’.
% La réponse à la question ajout_fin(9,[2,4,6],R). sera R=[2,4,6,9] (deux clauses sont nécessaires).
ajout_fin(X,[],[X]):-!.
ajout_fin(X,[Y|L],[Y|R]):-
    ajout_fin(X,L,R).

% Les tests unitaires :
:-begin_tests(chp0ex4).
test('ajout_fin(9,[2,4,6],R)',[true(R=[2,4,6,9])]):-ajout_fin(9,[2,4,6],R).
:-end_tests(chp0ex4).

:-run_tests(chp0ex4:'ajout_fin(9,[2,4,6],R)').
