% Définir somme(L,S) ayant la signification : ’S est la somme des nombres appartenant à L’.
% La réponse à la question somme([2,4,6],S). sera S=12.
somme([],0).
somme([X|L],S):-
    somme(L,S1),
    S is S1+X.

% Les tests unitaires :
:-begin_tests(chp0ex10).
test('somme([2,4,6],S)',[true(S=12)]):-somme([2,4,6],S).
:-end_tests(chp0ex10).

:-run_tests(chp0ex10).
