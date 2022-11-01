:-use_module("./ex_1.pl").
:-use_module("./ex_2.pl").

% 1. Définir la règle cout(Case,Cout)
% qui permet d’exprimer le coût de passage de la case Case vers la sortie
% sans tenir compte des frontières (cout(Case,Cout) sera considéré comme une heuristique).

% 2. Écrire la règle size(C h, G) qui renvoie le coût du chemin déjà parcouru.

% 3. Écrire les prédicats deplace(Ch, NvCh, Cout)
% qui permettent de calculer les positions suivantes dans le labyrinthe avec leurs coûts Cout respectifs.
% Ch contient la liste des cases déjà parcourues.
% NvCh représente cette même liste à laquelle on a ajouté la nouvelle position.
% Cout représente la coût réel du nouveau chemin NvCh auquel on a ajouté une estimation de ce qu’il reste à parcourir.

% 4. Définir le prédicat récursif parcoursSuivant(X,Acc,R)
% qui calcule, pour un parcours X de profondeur n tous les parcours suivants de profondeur n + 1 dans R,
% de la façon suivante : [[Cout1, Ch1], [Cout2, Ch2], . . . [Coutm, Chm]]

% 5. Définir le prédicat insere(L1, L2, R) qui insère les éléments de la liste L1 dans la liste
% L2 avec le résultat R. Cette insertion s’effectue en deux étapes :
% (a) par ordre croissant du coût d’un chemin auquel on a ajouté une heuristique,
% (b) par ordre décroissant du coût réel d’un chemin, si l’ordre précédent donne une égalité.
% Définir le prédicat insereC(L, Ch, R)
% correspondant à ces étapes qui insère Ch où bon endroit dans la liste L pour donner le résultat R.

% 6. Définir le prédicat récursif heuristique(L, C h)
% qui permet de calculer à l’aide d’une recherche avec heuristique le chemin avec le meilleur coût.
% La variable L correspond à la liste des parcours (accompagnée du coût),
% tandis que Ch correspond à une solution potentielle.

% 7. Définir le prédicat d’appel labyrinthe(Sol)
% qui renvoie la liste Sol des cases du labyrinthe par lesquelles il faut passer pour résoudre le problème.
