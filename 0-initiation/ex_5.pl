% Définir inclus(L,M) ayant la signification : ’Tous les éléments de la liste L se trouvent dans la liste M’,
% L est une sous-liste de M sans tenir compte de l’ordre des éléments mais seulement de leurs occurrences.
% La réponse à la question inclus([3,1],[1,2,3,4]). doit être true.
% La réponse à la question inclus([1,1],[1,2,3,4]). doit être false.
% Le prédicat inclus
inclus([],_).
inclus([X|L],M):-
   ote_element(X,M,M1),
   inclus(L,M1).
% Le prédicat appartient_et_ote
ote_element(X,[X|L],L).
ote_element(X,[Y|L],[Y|R]):-
   ote_element(X,L,R).

% Les tests unitaires :
:-begin_tests(chp0ex5).
test('inclus([3,1],[1,2,3,4])',[nondet,true]):-inclus([3,1],[1,2,3,4]).
test('inclus([1,1],[1,2,3,4])',[nondet,false]):-inclus([1,1],[1,2,3,4]).
:-end_tests(chp0ex5).

:-run_tests(chp0ex5).
