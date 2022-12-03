% Exercice 1 : Bungalow
:-use_module(library(lists)).

% Cas terminal, on retire le premier élément de la liste
membreRetire(X,[X|L],L).
% Sinon on prend un autre élément de la liste
membreRetire(X,[Y|L],[Y|L1]):-
    membreRetire(X,L,L1).

% Cas terminal, on a associé tous les éléments de chaque liste
elementMembre([],_).
% Sinon on prend un élément de la première liste et on l'associe
% avec un élément de la seconde via le prédicat membreRetire
% puis on continue avec les autres éléments
elementMembre([X|Y],L2):-
    membreRetire(X,L2,L),
    elementMembre(Y,L).

% 1. Generer et tester
solution(S):-
    % 1.1. Les 5 regions sont : Alsace, Bourgogne, Centre, Limousin, Picardie.
    S=[bung(alsace,H1,N1,F1), bung(bourgogne,H2,N4,F4),
    bung(centre,H3,N3,F3), bung(limousin,H4,N4,F4), bung(picardie,H5,N5,F5)],
    % 1.2. Les horaires d’arrivée sont : 9h30, 11h, 13h, 15h, 16h30.
    elementMembre([H1,H2,H3,H4,H5], [1,2,3,4,5]),
    % 1.3. Les nombres de personnes sont : 9, 12, 17, 20, 24.
    elementMembre([N1,N2,N3,N4,N5], [9,12,17,20,24]),
    % 1.4. Les familles sont : 2, 3, 4, 5, 6.
    elementMembre([F1,F2,F3,F4,F5], [2,3,4,5,6]),
    % 1.5. Les Bourguignons sont arrivés deux heures après la famille composée de 4 membres.
    member(H2, [3,4]), F4 \= 4,
    % 1.6. Les Bourguignons sont arrivés avant les Picards.
    H2 < H5,
    % 1.7. Les Picards sont logés au numéro 9.
    N5 = 9,
    % 1.8. Les Picards ne sont pas trois.
    F5 \= 3,
    % 1.9. Deux personnes occupent le bungalow numéro 12 et elles ne sont pas Alsaciennes ni Bourguignones.
    member(bung(R9,_,12,2), S), R9 \= alsace, R9 \= bourgogne,
    % 1.10. La famille composée de 5 membres est logée au numéro 24. Elle est arrivée juste avant les Alsaciens.
    member(bung(_,H10,24,5), S), H10 < H1,
    % 1.11. Les Alsaciens ne sont pas quatre.
    F1 \= 4,
    % 1.12. Les Limousins occupent le bungalow numéro 17
    N4 = 17,
    % 1.13. Les Limousins sont arrivés à 11h.
    H4 = 2.

% 2. backtracking
solution2(S):-
    % 1.1. Les 5 regions sont : Alsace, Bourgogne, Centre, Limousin, Picardie.
    S=[bung(alsace,H1,N1,F1), bung(bourgogne,H2,N4,F4),
    bung(centre,H3,N3,F3), bung(limousin,H4,N4,F4), bung(picardie,H5,N5,F5)],
    % 1.2. Les horaires d’arrivée sont : 9h30, 11h, 13h, 15h, 16h30.
    elementMembre([H1,H2,H3,H4,H5], [1,2,3,4,5]),
    % 1.6. Les Bourguignons sont arrivés avant les Picards.
    H2 < H5,
    % 1.13. Les Limousins sont arrivés à 11h.
    H4 = 2,
    % 1.3. Les nombres de personnes sont : 9, 12, 17, 20, 24.
    elementMembre([N1,N2,N3,N4,N5], [9,12,17,20,24]),
    % 1.7. Les Picards sont logés au numéro 9.
    N5 = 9,
    % 1.12. Les Limousins occupent le bungalow numéro 17
    N4 = 17,
    % 1.4. Les familles sont : 2, 3, 4, 5, 6.
    elementMembre([F1,F2,F3,F4,F5], [2,3,4,5,6]),
    % 1.5. Les Bourguignons sont arrivés deux heures après la famille composée de 4 membres.
    member(H2, [3,4]), F4 \= 4,
    % 1.8. Les Picards ne sont pas trois.
    F5 \= 3,
    % 1.11. Les Alsaciens ne sont pas quatre.
    F1 \= 4,
    % 1.9. Deux personnes occupent le bungalow numéro 12 et elles ne sont pas Alsaciennes ni Bourguignones.
    member(bung(R9,_,12,2), S), R9 \= alsace, R9 \= bourgogne,
    % 1.10. La famille composée de 5 membres est logée au numéro 24. Elle est arrivée juste avant les Alsaciens.
    member(bung(_,H10,24,5), S), H10 < H1.

% 3. PLC
:- use_module(library(clpfd)).

solution3([[alsace,bourgogne,centre,limousin,picardie],
    [H1,H2,H3,H4,H5],
    [N1,N2,N3,N4,N5],
    [F1,F2,F3,F4,F5]]):-
    % 1.1.
    [alsace,bourgogne,centre,limousin,picardie] ins 1..5,
    all_different([alsace,bourgogne,centre,limousin,picardie]),
    % 1.2. Les horaires d’arrivée sont : 9h30, 11h, 13h, 15h, 16h30.
    [H1,H2,H3,H4,H5] ins 1..5,
    all_different([H1,H2,H3,H4,H5]),
    % 1.3. Les nombres de personnes sont : 9, 12, 17, 20, 24.
    [N1,N2,N3,N4,N5] ins 1..5,
    all_different([N1,N2,N3,N4,N5]),
    % 1.4. Les familles sont : 2, 3, 4, 5, 6.
    [F1,F2,F3,F4,F5] ins 2..6,
    all_different([F1,F2,F3,F4,F5]),
    % 1.5. Les Bourguignons sont arrivés deux heures après la famille composée de 4 membres.
    member(H2, [3,4]), F4 #\= 4,
    % 1.6. Les Bourguignons sont arrivés avant les Picards.
    H2 #< H5,
    % 1.7. Les Picards sont logés au numéro 9.
    N5 #= 9,
    % 1.8. Les Picards ne sont pas trois.
    F5 #\= 3,
    % 1.9. Deux personnes occupent le bungalow numéro 12 et elles ne sont pas Alsaciennes ni Bourguignones.
    member(bung(R9,_,12,2), S), R9 #\= alsace, R9 #\= bourgogne,
    % 1.10. La famille composée de 5 membres est logée au numéro 24. Elle est arrivée juste avant les Alsaciens.
    member(bung(_,H10,24,5), S), H10 #< H1,
    % 1.11. Les Alsaciens ne sont pas quatre.
    F1 #\= 4,
    % 1.12. Les Limousins occupent le bungalow numéro 17
    N4 #= 17,
    % 1.13. Les Limousins sont arrivés à 11h.
    H4 #= 2.
    % Enumeration des solutions
    labeling([], [alsace,bourgogne,centre,limousin,picardie,
        H1,H2,H3,H4,H5,
        N1,N2,N3,N4,N5,
        F1,F2,F3,F4,F5]).

% 4. Tableau

% Région    | Nombre | Heure d'arrivée | Bungalow
% ____________________________________________
% Alsace    |   3    |  15h00          |  20
% Bourgogne |   5    |  13h00          |  24
% Centre    |   2    |  16h30          |  12
% Limousin  |   4    |  11h00          |  17
% Picardie  |   6    |  09h30          |  9