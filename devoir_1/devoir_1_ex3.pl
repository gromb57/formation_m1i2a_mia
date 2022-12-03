% Exercice 3

parcoursSuivant(X,N_PC,R):-
    deplace(X,Parcours,Cout),
    \+ member([Cout,Parcours],N_PC),!,
    parcoursSuivant(X,[[Cout,Parcours]|N_PC],R).
parcoursSuivant(_,R,R).

size([],0).
size([_|L],G):-
    size(L,G1),
    G is G1+1.

insere([],R,R).
insere([X|LC2],LC,R):-
    insereC(LC,X,LCX),
    insere(LC2,LCX,R).
insereC([],X,[X]).
insereC([[Cout,L]|LC],[CoutX,LX],[[CoutX,LX],[Cout,L]|LC]):-
    Cout > CoutX.
insereC([[Cout,L]|LC],[CoutX,LX],[[Cout,L]|LCX]):-
    Cout < CoutX,
    insereC(LC,[CoutX,LX],LCX).
insereC([[Cout,L]|LC],[CoutX,LX],[[Cout,L]|LCX]):-
    Cout = CoutX,
    size(L,SizeL),
    size(LX,SizeLX),
    SizeL > SizeLX,
    insereC(LC,[CoutX,LX],LCX).
insereC([[Cout,L]|LC],[CoutX,LX],[[CoutX,LX],[Cout,L]|LC]):-
    Cout = CoutX,
    size(L,SizeL),
    size(LX,SizeLX),
    SizeL =< SizeLX.

contientEtatFinal([A|_]):-
    arrivee(A).

etatFinal([[_,R]|_],R):-
    contientEtatFinal(R).

heuristique(N_L,R):-
    etatFinal(N_L,R).
heuristique([[_,L]|LR],R):-
    parcoursSuivant(L,[],NL),
    insere(LR,NL,N_L),
    heuristique(N_L,R).

resolutionHeuristique(R):-
    depart(A),
    cout(A, Cout1),
    size([A],Cout2),
    Cout is Cout1+Cout2,
    heuristique([[Cout,[A]]],R1),
    reverse(R1,R).

% largeur
ajout([],L2,L2):- !.
ajout([X|L1],L2,[X|L3]):-
    ajout(L1,L2,L3).

etageSuivant([X|L],NV_L,R):-
    contientEtatFinal(X),!,
    etageSuivant(L,NV_L,R).
etageSuivant([X|L],NV_L,R):-
    parcoursSuivant(X,[],PC),
    ajout(PC,NV_L,NV_L1),
    etageSuivant(L,NV_L1,R).

% Il n'y a plus aucun chemin a etendre
largeur([],_):- !, fail.
% Permet de tester si on a trouve une solution
largeur(N_L,R):-
    etatFinal(N_L,R).
% On etend la liste des chemins d'un pas
largeur(L,R):-
    etageSuivant(L,[],N_L),
    largeur(N_L,R).

resolutionLargeur(R):-
    depart(C),
    largeur([[C]],R1),
    reverse(R1,R).

% profondeur
parcours([C|Parcours],[C|Parcours]):-
    arrivee(C),!.

parcours(Parcours,R):-
    deplace(_, Parcours,Suivant),
    parcours(Suivant,R).

resolutionProfondeur(R):-
    depart(C),
    parcours([C],R1),
    reverse(R1,R).

% 1. Donner seulement les 6 prédicats qu’il faut redéfinir pour le problème : lieu, rue, route, cout, distance, deplace.

lieu('Banque', [250, 310]).
lieu('Battant', [210, 340]).
lieu('BeauxArts', [460, 420]).
lieu('Boulangerie', [380, 210]).
lieu('Cinéma', [400, 240]).
lieu('Collège', [220, 210]).
lieu('EDF', [630, 90]).
lieu('Hôpital', [80, 0]).
lieu('Lycée', [720, 200]).
lieu('Mairie', [300, 120]).
lieu('Maison', [120, 420]).
lieu('Musée', [500, 70]).
lieu('République', [580, 400]).
lieu('Veil', [0, 25]).

%chemin([XA, YA], [XB, YB]).
chemin([250, 310], [210, 340], 40). % Banque-Battant
chemin([250, 310], [380, 210], 180). % Banque-Boulangerie
chemin([250, 310], [400, 240], 200). % Banque-Cinéma
chemin([250, 310], [220, 210], 40). % Banque-Collège
chemin([210, 340], [120, 420], 100). % Battant-Maison
chemin([210, 340], [0, 25], 240). % Battant-Veil
chemin([460, 420], [400, 240], 80). % BeauxArts-Cinéma
chemin([460, 420], [0, 25], 140). % BeauxArts-République
chemin([380, 210], [300, 120], 80). % Boulangerie-Mairie
chemin([380, 210], [500, 70], 160). % Boulangerie-Musée
chemin([380, 210], [580, 400], 220). % Boulangerie-République
chemin([220, 210], [300, 120], 30). % Collège-Mairie
chemin([220, 210], [80, 0], 160). % Collège-Hôpital
chemin([630, 90], [720, 200], 170). % EDF-Lycée
chemin([630, 90], [500, 70], 140). % EDF-Musée
chemin([80, 0], [0, 25], 90). % Hôpital-Veil
chemin([720, 200], [580, 400], 240). % Lycée-République

route([XA, YA], [XB, YB], D) :- chemin([XA, YA], [XB, YB], D).
route([XA, YA], [XB, YB], D) :- chemin([XB, YB], [XA, YA], D).

cout(A, C) :- arrivee(B), route(A, B, D), C is D.

distance([], 0).
distance([_], 0).
distance([X,Y|L], D):-
    distance([Y|L], D1),
    route(X, Y, D2),
    D is D1+D2.

deplace(X, P, C):-
    distance(P, C1),
    route(X, Y, D),
    \+ member(Y, P),
    deplace(Y, [X|P], C2),
    C is C1+D.

% 2.
depart([120, 420]).
arrivee([500, 70]).

% ?- resolutionHeuristique(R).
% false.

% ?- resolutionLargeur(R).
% le programme ne termine pas

% ?- resolutionProfondeur(R).
% false.
