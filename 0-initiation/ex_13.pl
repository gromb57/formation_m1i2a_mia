% Le loup, la chèvre et le chou

% Un loup, une chèvre et un chou doivent traverser une rivière et s’adressent à un batelier
% qui ne peut transporter que l’un d’entre eux à la fois. Hors de la présence du batelier,
% la chèvre croquera le chou et le loup dégustera la chèvre.
% On se propose d’écrire un programme PROLOG qui calcule et affiche à l’écran la suite des traversées
% permettant le passage sur l’autre rive.
% Technique conseillée :
% Les rives sont numérotées 1 et 2.
% Un état est représenté par un triplet [R1,R2,B]
% où R1 est la liste des individus situés sur la rive 1,
% R2 la liste des individus situés sur la rive 2, et le bateau se trouve sur la rive B.
% L’état de départ est ainsi [[chèvre,chou,loup],[],1].
% Lorsque l’état [[],[chèvre,chou,loup],2] est atteint, la mission est remplie.
% La liste des états parcourus constitue alors la solution au problème.
% Notez qu’à chaque passage de la rive i à la rive j,
% on vérifiera qu’on n’a pas laissé sur la rive i un des couples interdits,
% et qu’on ne se retrouve pas dans un des états dans lesquels on est déjà passé.

%etat_de_depart([[chevre,chou,loup],[],1]).
%etat_arrivee([[],[chevre,chou,loup],2]).
%etat_interdit([[chevre,loup],_,1]).
%etat_interdit([[chou,chevre],_,1]).
%etat_interdit([[chevre,loup],_,2]).
%etat_interdit([[chou,chevre],_,2]).

% PRE-REQUIS
:-use_module(library(lists)).
% ote\_element/3 permet d'ôter un élément (Argument 1) d'une liste (Argument 2)
% pour obtenir une nouvelle liste amputée de cet élément (Argument 3).
% Si l'élément (Argument 1) n'appartient à la liste (Argument 2), ce prédicat échoue.
% Il faut mieux privilégier le prédicat natif select/3 de la bibliotheque lists.
ote_element(X,[X|L],L).
ote_element(X,[Y|L],[Y|R]):-
   ote_element(X,L,R).
% renverse/3 permet à partir d'une liste (Argument 1) d'obtenir sa liste renversée
% (Argument 3). L'Argument 2 permet de construire la réponse au cours des appels
% récursifs (sa valeur est à vide à l'appel de ce prédicat).
% Il faut mieux privilégier le prédicat natif reverse/2 de la bibliotheque lists.
renverse([],Acc,Acc).
renverse([E|L],Acc,R):-
   renverse(L,[E|Acc],R).
% INITIALISATION DES COUPLES INTERDITS
% Ces faits permettent de définir tous les couples interdits
couple_interdit([[chevre,chou],_,2]).
couple_interdit([[chevre,loup],_,2]).
couple_interdit([[chevre,chou,loup],_,2]).
couple_interdit([_,A,1]):-
   couple_interdit([A,_,2]).

% INITIALISATION DEPART ET ARRIVEE
% Ces faits permettent de définir respectivement l'état de départ et l'état de fin
depart([[chevre,chou,loup],[],1]).     % A l'état initial, les trois animaux sont sur la berge 1
                                       % tout comme le passeur
arrivee([[],[chevre,chou,loup],2]).    % A l'état final, les trois animaux sont sur la berge 2
                                       % tout comme le passeur
% TRI DE LA LISTE
% Le prédicat tri_liste/2 permet de trier la liste en premier argument : la liste triée est
% renvoyée dans le second argument.
tri_liste([],[]).             % initialisation de la réponse à vide (Argument 2) lorsque tous les
                              % éléments de la liste à trier (Argument 1) ont été traités
tri_liste(L,[chevre|R]):-     % ajout de chèvre en première place de la réponse
   ote_element(chevre,L,LL),  % si elle est élément de la liste à trier
!,
   tri_liste(LL,R).
tri_liste(L,[chou|R]):-
   ote_element(chou,L,LL),
   !,
   tri_liste(LL,R).
tri_liste(L,[loup|R]):-
   ote_element(loup,L,LL),
   tri_liste(LL,R).
% puisque chèvre est élément, on ne veut pas
% pouvoir trouver un autre élément en première
% place de la réponse pour cet appel d'où le cut
% lancement récursif sur le reste de la liste
% ajout de chou en première place de la réponse
% si il est élément de la liste à trier
% puisque chou est élément, on ne veut pas
% pouvoir trouver un autre élément en première
% place de la réponse pour cet appel d'où le cut
% lancement récursif sur le reste de la liste
% ajout de loup en première place de la réponse
% si il est élément de la liste à trier
% lancement récursif sur le reste de la liste
% CALCUL DE LA SOLUTION
% appel principal dont l'objectif est d'appeler le prédicat traverse/2 avec
% comme premier argument une liste comprenant l'état actuel c-à-d l'état de départ.
solution(S):-
  depart(L),
  traverse([L],S),
  nl,
% initialisation de l'état initial
% appel de la résolution
% permet d'effectuer un saut de ligne dans la console
  write('La reponse est :'),   % permet de d'afficher du texte dans la console
  nl,
  write(S),          % permet de d'afficher de la solution dans la console
  nl.
% Le prédicat traverse/2 a simplement deux arguments : le premier est une liste
% d'états rangés dans le sens contraire de leur chronologie (le premier état est
% l'état courant, le dernier l'état initial). Ce premier argument va donc accumuler
% les états traversés en les empilant par l'avant. Le second argument est une liste
% d'états solution.
traverse([E|L],R):-
  arrivee(E),
  renverse([E|L],[],R).
% prédicat d'arrêt
% si la l'état courant est l'état final
% on calcule la réponse en retournant la liste des
% états traversés
traverse([[R1,R2,1]|L],R):- % traversée du bord 1 au bord 2
                            % l'état courant est alors [R1,R2,1]
    ote_element(X,R1,R1_new), % prélèvement d'un animal (Argument 1) de la
    % berge 1 (Argument 2); les animaux restant sur
                                %  la berge 1 sont identifiés par la liste de
                                % l'argument 3.
    tri_liste([X|R2],R2_new), % ajout de cet animal sur la berge 2 (Argument 1)
                        % et tri de la nouvelle liste (Argument 2)
    \+couple_interdit([R1_new,R2_new,2]), % absence de couples interdits
    \+member([R1_new,R2_new,2],L),   % on n'est pas en train de calculer un état
                                % dans lequel on est déjà passé
    traverse([[R1_new,R2_new,2],[R1,R2,1]|L],R). % appel récursif en ajoutant
                                % le nouvel état calculé à la
                                % liste des états déjà traversés

traverse([[R1,R2,2]|L],R):- % traversée du bord 2 au bord 1 (même principe que 1 -> 2)
    ote_element(X,R2,R2_new),
    tri_liste([X|R1],R1_new),
    \+couple_interdit([R1_new,R2_new,1]),
    \+member([R1_new,R2_new,1],L),
    traverse([[R1_new,R2_new,1],[R1,R2,2]|L],R).
    traverse([[R1,R2,B]|L],R):- % traversée à vide
    B1 is mod(B,2),           % calcul de la nouvelle berge pour le passeur :
    B_new is B1+1,            % modulo(1,2)+1=2 et modulo(2,2)+1=1
    \+couple_interdit([R1,R2,B_new]),    % absence de couples interdits
    \+member([R1,R2,B_new],L),          % on n'est pas en train de calculer un état
                                % dans lequel on est déjà passé
    traverse([[R1,R2,B_new],[R1,R2,B]|L],R). % appel récursif en ajoutant
                                % le nouvel état calculé à la
                                % liste des états déjà traversés