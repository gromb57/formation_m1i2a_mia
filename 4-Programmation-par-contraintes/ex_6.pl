% Exercice 6 - Soyons logique

% 1. Question 1 :
    % Le plus simple est de prendre les seuls mois proposés et de faire la liste
    unMoisApres(octobre,septembre).
    unMoisApres(janvier,decembre).

% 2. Question 2 :

% Idem question 1
deuxMoisApres(decembre,octobre).
deuxMoisApres(mars,janvier).

%3. Question 3 :
% Cas terminal, on a trouvé l'élément dans la liste
membre(X,[X|_L]):-!.
% Sinon on cherche dans le reste de la liste
membre(X,[_|L]):-
    membre(X,L).

%4. Question 4 :

% Cas terminal, on retire le premier élément de la liste
membreRetire(X,[X|L],L).
% Sinon on prend un autre élément de la liste
membreRetire(X,[Y|L],[Y|L1]):-
    membreRetire(X,L,L1).

%5. Question 5 :

% Cas terminal, on a associé tous les éléments de chaque liste
element_membre([],_).
% Sinon on prend un élément de la première liste et on l'associe
% avec un élément de la seconde via le prédicat membreRetire
% puis on continue avec les autres éléments
element_membre([X|Y],L2):-
    membreRetire(X,L2,L),
    element_membre(Y,L).

%6. Question 6 :

solution(S):-
    % Phrase 1
    S=[ami(arnaud,M1,S1,V1), ami(christian,M2,S2,V2), ami(hubert,M3,S3,V3),
    ami(julien,M4,S4,V4), ami(stephane,M5,S5,V5) ],
    % Phrase 2
    element_membre([M1,M2,M3,M4,M5],[septembre,octobre,decembre,janvier,mars]),
    % Phrase 3
    element_membre([V1,V2,V3,V4,V5],[bordeaux,lens,nantes,saint_Etienne,lyon]),
    % Phrase 4
    element_membre([S1,S2,S3,S4,S5],[sc(1,0),sc(1,1),sc(2,1),sc(2,3),sc(3,2)]),
    % Phrase 5
    V4 = lyon,
    % Phrase 6
    V1 \= lens, V1 \=nantes,
    % Phrase 7
    V1 \= bordeaux, V3 \= bordeaux,
    % Phrase 8
    S5 = sc(ScD,ScE), ScD < ScE,
    % Phrase 9
    membre(ami(_,_,sc(ScD1,ScE1),lyon),S), ScD1 > ScE1,
    % Phrase 10
    membre(ami(_,_,sc(ScD2,ScE2),nantes),S), ScD2 > ScE2,
    % Phrase 11
    membre(ami(_,_,sc(2,1),bordeaux),S),
    % Phrase 12
    unMoisApres(M1,M4),
    % Phrase 13
    membre(ami(_,M6,_,bordeaux),S), membre(ami(_,M7,sc(1,0),_),S), deuxMoisApres(M6,M7),
    % Phrase 14
    membre(ami(_,M8,sc(2,3),_),S), membre(ami(_,M9,_,nantes),S), unMoisApres(M9,M8).

%7. Question 7 :

solution(S):-
    % Phrase 1
    S=[ami(arnaud,M1,S1,V1), ami(christian,M2,S2,V2), ami(hubert,M3,S3,V3),
    ami(julien,M4,S4,V4), ami(stephane,M5,S5,V5) ],
    % Phrase 3
    element_membre([V1,V2,V3,V4,V5],[bordeaux,lens,nantes,saint_Etienne,lyon]),
    % Phrase 5
    V4 = lyon,
    % Phrase 6
    V1 \= lens, V1 \=nantes,
    % Phrase 7
    V1 \= bordeaux, V3 \= bordeaux,
    % Phrase 4
    element_membre([S1,S2,S3,S4,S5],[sc(1,0),sc(1,1),sc(2,1),sc(2,3),sc(3,2)]),
    % Phrase 8
    S5 = sc(ScD,ScE), ScD < ScE,
    % Phrase 9
    membre(ami(_,_,sc(ScD1,ScE1),lyon),S), ScD1 > ScE1,
    % Phrase 10
    membre(ami(_,_,sc(ScD2,ScE2),nantes),S), ScD2 > ScE2,
    % Phrase 11
    membre(ami(_,_,sc(2,1),bordeaux),S),
    % Phrase 2
    element_membre([M1,M2,M3,M4,M5],[septembre,octobre,decembre,janvier,mars]),
    % Phrase 12
    unMoisApres(M1,M4),
    % Phrase 13
    membre(ami(_,M6,_,bordeaux),S), membre(ami(_,M7,sc(1,0),_),S), deuxMoisApres(M6,M7),
    % Phrase 14
    membre(ami(_,M8,sc(2,3),_),S), membre(ami(_,M9,_,nantes),S), unMoisApres(M9,M8).

%8. Question 8 :
 
:- use_module(library(clpfd)).

domains(L,T):-
    L ins T.
solution([[Arnaud, Christian, Hubert, Julien, Stephane], [Bordeaux, Lens, Nantes,
    Saint_Etienne, Lyon],[S1, S2, S3, S4, S5]]):-
    % Phrase 1, on va prendre comme domaine de chaque variable
    % les valeurs des mois (cf. phrase 2)
        domains([Arnaud,Christian,Hubert,Julien,Stephane], (9..10) \/ (12..13) \/ {15}),
        all_different([Arnaud,Christian,Hubert,Julien,Stephane]),
    % Phrase 2
        Septembre is 9, Octobre is 10, Decembre is 12, Janvier is 13, Mars is 15,
    % Phrase 3 Idem pour le domaine
        domains([Bordeaux,Lens,Nantes,Saint_Etienne,Lyon], (9..10) \/ (12..13) \/ {15}),
        all_different([Bordeaux,Lens,Nantes,Saint_Etienne,Lyon]),
    % Phrase 4, idem pour le domaine de plus on définit les scores
    % S1 = (1,0), S2 = (1,1), S3=(2,1), S4=(2,3), S5=(3,2)
    domains([S1,S2,S3,S4,S5],(9..10)\/(12..13)\/{15}),
    all_different([S1,S2,S3,S4,S5]),
    % Phrase 5
    Julien #= Lyon,
    % Phrase 6
    Arnaud #\= Lens, Arnaud #\= Nantes,
    % Phrase 7
    Arnaud #\= Bordeaux, Hubert #\= Bordeaux,
    % Phrase 8
    Stephane #= S4,
    % Phrase 9
    (Lyon #= S1 #\/ Lyon #=S3 #\/ Lyon #=S5),
    % Phrase 10
    (Nantes #= S1 #\/ Nantes #=S3 #\/ Nantes #=S5),
    % Phrase 11
    Bordeaux #= S3,
    % Phrase 12
    Arnaud #= Julien + 1,
    % Phrase 13
    Bordeaux #= S1 + 2,
    % Phrase 14
    Nantes #= S4 + 1,
    % Enumeration des solutions
    labeling([],[Arnaud,Christian,Hubert,Julien,Stephane,Bordeaux,Lens,
    Nantes,Saint_Etienne,Lyon,S1,S2,S3,S4,S5]).

%9. Question 9 :

%S = [ami(arnaud,octobre,sc(1,1),saint_Etienne),
%      ami(christian,mars,sc(2,1),bordeaux),
%      ami(hubert,janvier,sc(1,0),nantes),
%      ami(julien,septembre,sc(3,2),lyon),
%      ami(stephane,decembre,sc(2,3),lens)]
