% Définir dernier(X,L) ayant la signification : ’X est le dernier terme de la liste L’.
% La réponse à la question dernier(X,[2,4,6]). sera X=6 (deux clauses sont nécessaires).
dernier(X,[X]):-!.
dernier(X,[_|L]):-
   dernier(X,L).

% Les tests unitaires :
:-begin_tests(chp0ex2).
test('dernier(X,[1,2,3])',[true(X==3)]):-dernier(X,[1,2,3]).
test('dernier(X,[2,4,6])',[true(X==6)]):-dernier(X,[2,4,6]).
:-end_tests(chp0ex2).

:-run_tests(chp0ex2).
