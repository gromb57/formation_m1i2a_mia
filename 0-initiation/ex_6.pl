% Définir renverse_liste(L,Acc,M), dont le poids peut être de 2 ou 3,
% qui permet de renverser une liste L donnée et retourne le résultat dans M avec ou sans accumulateur Acc.
% Ainsi, la liste renversée de [a,b,c] est la liste [c,b,a].
renverse_liste(X,R):-
    renverse_liste(X,[],R).

renverse_liste([],M,M).
renverse_liste([X|L],Acc,M):-
    renverse_liste(L,[X|Acc],M).

% Les tests unitaires :
:-begin_tests(chp0ex6).
test('renverse_liste([1,2,3],[3,2,1])'):-renverse_liste([1,2,3],[3,2,1]).
:-end_tests(chp0ex6).

:-run_tests(chp0ex6).
