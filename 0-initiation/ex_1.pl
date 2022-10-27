% Définir le prédicat premier(X,L) ayant la signification : ’X est le premier terme de la liste L’.
% La réponse à la question premier(X,[2,4,6]) sera X=2 (une clause suffit).
premier(X,[X|_]).

% Les tests unitaires :
:-begin_tests(chp0ex1).
test('premier(X,[1,2,3])',[true(X==1)]):-premier(X,[1,2,3]).
test('premier(X,[2,4,6])',[true(X==2)]):-premier(X,[2,4,6]).
:-end_tests(chp0ex1).

:-run_tests(chp0ex1).