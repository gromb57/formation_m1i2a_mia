% Définir longueur(L,A) ayant la signification : ’L est de longueur A’.
% La réponse à la question longueur([2,4,6],A). sera A=3.
% Notez qu’un prédicat prédéfini effectue ce traitement : il s’agit de length(L,A).
longueur([],0).
longueur([_|L],A):-
    longueur(L,A1),
    A is A1+1.

% Les tests unitaires :
:-begin_tests(chp0ex9).
test('length([2,4,6],A)',[true(A=3)]):-length([2,4,6],A).
test('longueur([2,4,6],A)',[true(A=3)]):-longueur([2,4,6],A).
:-end_tests(chp0ex9).

:-run_tests(chp0ex9).