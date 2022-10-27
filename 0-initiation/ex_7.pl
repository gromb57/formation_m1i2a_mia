% Définir sous_liste_droite(L,K) ayant la signification : ’K est une sous-liste droite de la liste L’.
% Les sous-listes droites de [a,b,c] sont [], [c], [b,c] et [a,b,c].
sous_liste_droite(L,L).
sous_liste_droite([_|L],K) :- sous_liste_droite(L,K).

% Les tests unitaires :
:-begin_tests(chp0ex7).
test('sous_liste_droite([1,2,3],R)',all(R==[[1,2,3],[2,3],[3],[]])):-sous_liste_droite([1,2,3],R).
:-end_tests(chp0ex7).

:-run_tests(chp0ex7).