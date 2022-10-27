% Définir sous_liste_gauche(L,K) ayant la signification : ’K est une sous-liste gauche de la liste L’.
% Les sous-listes gauches de [a,b,c] sont [], [a], [a,b] et [a,b,c].
sous_liste_gauche([X|L],[X|K]) :-
    sous_liste_gauche(L,K).
sous_liste_gauche(_, []).

% Les tests unitaires :
:-begin_tests(chp0ex8).
test('sous_liste_gauche([1,2,3],R)',all(R==[[1,2,3],[1,2],[1],[]])):-sous_liste_gauche([1,2,3],R).
:-end_tests(chp0ex8).

:-run_tests(chp0ex8).