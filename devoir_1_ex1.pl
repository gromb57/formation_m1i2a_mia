% Exercice 1

% Réaliser les prédicats prolog qui permettent :
% 1. de créer un palindrome à partir d’une liste, les tests d’acceptations seraient :
creerPal([], []). 
creerPal([X], [X]). 
creerPal([X|Y], L) :-
    creerPal(Y, L1),
    append([X|L1], [X], L).

% Les tests unitaires :
:-begin_tests(devoir1ex1petit1).
test('creerPalP',[true(L=[a,b,c,d,c,b,a])]):- creerPal([a,b,c,d],L).
test('creerPalVide',[true(L=[])]):- creerPal([],L).
test('creerPal1',[true(L=[a])]):- creerPal([a],L).
:-end_tests(devoir1ex1petit1).

%:-run_tests(devoir1ex1petit1).

% 2. d’extraire un element sur deux d’une liste et renvoie ces elements dans une autre liste,
% les tests d’acceptations seraient :

extrait([], []).
extrait([a], [a]).
extrait([a,_|X], [a|L]) :-
    extrait(X, L).

% Les tests unitaires :
:-begin_tests(devoir1ex1petit2).
test('extraitP',[true(L=[a,c,e])]):- extrait([a,b,c,d,e],L).
test('extraitVide',[true(L=[])]):- extrait([],L).
test('extrait1',[true(L=[a])]):- extrait([a],L).
test('extrait2',[true(L=[a])]):- extrait([a,b],L).
:-end_tests(devoir1ex1petit2).

%:-run_tests(devoir1ex1petit2).

