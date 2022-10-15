% La bilbliothèque de test unitaire
:-use_module(library(plunit)).

% Les tests unitaires :
:-begin_tests(chp0).
test('habite(X,vesoul)',[true(X==laurent)]):-habite(X,vesoul).
test('habiteA(X,vesoul)',[true(X\=christophe)]):-habite(X,vesoul).
test('habiteAll(X,vesoul)',[all(X==[laurent,christophe])]):-habite(X,vesoul).
test('habiteAllF(X,vesoul)',[all(X==[christophe,laurent])]):-habite(X,vesoul).
test('habiteSets(X,vesoul)',[set(X==[christophe,laurent])]):-habite(X,vesoul).
test('habite(X,besancon)',[fail]):-habite(X,besancon).
:-end_tests(chp0).
