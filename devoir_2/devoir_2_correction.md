# Exercice 1 : Brocante

## Question 1 :
On commence avec les librairies et le prédicat elementMembre/2 :
:-use_module(library(lists)).
:-use_module(library(clpfd)).

elementMembre([],_).
elementMembre([X|L1],L2):-
  select(X,L2,L3),
  elementMembre(L1,L3).

%Le prédicat qui était demandé pour Générer & Tester :

loisirGetT(S):-
% Domaines phrases 1 a 4
S = [bung(alsace,H1,N1,F1), bung(bourgogne,H2,N2,F2), bung(centre,H3,N3,F3),bung(limousin,H4,N4,F4),bung(picardie,H5,N5,F5)],
elementMembre([N1,N2,N3,N4,N5],[9,12,17,20,24]),
elementMembre([F1,F2,F3,F4,F5],[2,3,4,5,6]),
% Je multiplie par 10 pour avoir des entiers ça servira pour la PLC
% On peut aussi tout convertir en mn 9h30 = 9*60+30 = 570
Horaire = [95,110,130,150,165],
elementMembre([H1,H2,H3,H4,H5],Horaire),

% Phrase 5
member(bung(_,Heure1,_,4),S),
H2 is Heure1 + 20,
% Phrase 6
H2 < H5,
% Phrase 7
N5 is 9,
% Phrase 8
F5 \= 3,
% Phrase 9
member(bung(X,_,12,2),S),
X \= alsace,
X \= bourgogne,
% Phrase 10
member(bung(_,Heure2,24,5),S),
nth0(IndexH1,Horaire,H1),
nth0(IndexHeure2,Horaire,Heure2),
Heure2 is H1-1,
%% Une alternative serait d'utiliser le décalage maximum de 2 heures Heures2 >= H1 - 20, Heure2 < H1,
% Phrase 11
F1 \= 4,
% Phrase 12
N4 is 17,
% Phrase 13
H4 is 110.

## Question 2 :
Il faut réorganiser les phrases pour échouer au plus tôt :

loisirBck(S) :-
S = [bung(alsace,H1,N1,F1), bung(bourgogne,H2,N2,F2), bung(centre,H3,N3,F3),bung(limousin,H4,N4,F4),bung(picardie,H5,N5,F5)],
elementMembre([H1,H2,H3,H4,H5],[95,110,130,150,165]),
% Phrase 5
member(bung(_,Heure1,_,4),S),
H2 is Heure1 + 20,
% Phrase 6
H2 < H5,
% Phrase 10
member(bung(_,Heure2,24,5),S),
Heure2 >= H1-20,
Heure2 < H1,
% Phrase 13
H4 is 110,
elementMembre([N1,N2,N3,N4,N5],[9,12,17,20,24]),
% Phrase 7
N5 is 9,
% Phrase 12
N4 is 17,
elementMembre([F1,F2,F3,F4,F5],[2,3,4,5,6]),
% Phrase 8
F5 \= 3,
% Phrase 11
F1 \= 4,
% Phrase 9
member(bung(X,_,12,2),S),
X \= alsace,
X \= bourgogne.

## Question 3 :
Il faut choisir un domaine pour les valeurs, on va prendre les jours :

loisirPlc(L):-
  L = [Alsace, Bourgogne, Centre, Limousin, Picardie, Bungalow9, Bungalow12, Bungalow17, Bungalow20, Bungalow24, F2, F3, F4, F5, F6],
% Domaines phrases 1 a 4
 L ins {95,110,130,150,165},
 all_different([Alsace, Bourgogne, Centre, Limousin, Picardie]),
 all_different([Bungalow9, Bungalow12, Bungalow17, Bungalow20, Bungalow24]),
 all_different([F2, F3, F4, F5, F6]),
% Phrase 5
 Bourgogne #= F4 + 20,
% Phrase 6
 Bourgogne #< Picardie,
% Phrase 7
 Picardie #= Bungalow9,
% Phrase 8
 Picardie #\= F3,
% Phrase 9
 F2 #= Bungalow12,
 F2 #\= Alsace,
 F2 #\= Bourgogne,
% Phrase 10
 F5 #= Bungalow24,
 F5 #< Alsace,
 F5 #>= Alsace-20,
% Phrase 11
 Alsace #\= F4,
% Phrase 12
 Limousin #= Bungalow17,
% Phrase 13
 Limousin #= 110,
% Valuation
 labeling([], L),
% Ajout pour un joli affichage, mais non demandé
 joliAffichage(L).

%%% Non demandé
region(1,alsace). region(2,bourgogne). region(3,centre). region(4,limousin). region(5,picardie).
bunga(1,'n°9'). bunga(2,'n°12'). bunga(3,'n°17'). bunga(4,'n°20'). bunga(5,'n°24').
famille(1,2). famille(2,3). famille(3,4). famille(4,5). famille(5,6).
afficher([R,F,B],T,Nb):-
  region(R,Rn), write(Rn), write(' '),
  F1 is F-Nb,
  famille(F1,Fn), write(Fn), write(' '),
  T1 is T//10,
  write(T1), write('h'), (0 is T mod 10->write('00 ');write('30 ')),
  B1 is B-2*Nb,
  bunga(B1,Bn), write(Bn),nl.

joliAffichage(N1,N,_):- N1 > N, !.
joliAffichage(N,Nb,L):-
  nth1(N,L,X),
  findall(I,nth1(I,L,X),LI),
  afficher(LI,X,Nb),
  N1 is N+1,
  joliAffichage(N1,Nb,L).

domains([],_).
domains([X|L],Dom):-
  X in Dom,
  domains(L,Dom).

## Question 4 :
Région	Nombre	Heure Arrivée	Bungalow
Alsace	3	15h	20
Bourgogne	5	13h	24
Centre	2	9h30	12
Limousin	4	11h	17
Picardie	6	16h30	9

# Exercice 2 : Pok’expert 

## Question 1 :
Il faut définir les variables propositionnelles :

Pokémon : la créature est un pokémon
FlammeC : la créature a une flemme sur la coquille
Volcaropod : la créature est un volcaropode
Singe : la créature est en forme de singe
Ouisticram : la créature est un ouisticram
FlammeQ : la créature a une flamme sur la queue
Flamequeue : la créature est un flamequeue
Dragon : la créature est en forme de dragon
Salameche : la créature est un Salameche
Unecorne : La créature a une corne
Reptincel : la créature est un reptincel
AuMoins2Cornes : La créature a au moins 2 cornes
Dracaufeu :  la créature est un Dracaufeu
FlammeBl : la créature a une flamme bleue
MegDracX :  la créature est un Méga-Dracaufeu X
TroisCornes : La créature a trois cornes
MegDracY :  la créature est un Méga-Dracaufeu Y
On peut traduire les phrases en logique propositionnelle :

R1 : Pokemon /\ FlammeQ -> Flamequeue
R2 : Pokemon /\ FlammeC -> Volcaropod
R3 : Flamequeue /\ Singe -> Ouisticram
R4 : Flamequeue /\ Dragon -> Salameche
R5 : Salameche /\ Unecorne -> Reptincel
R6 : Salameche /\ AuMoins2Cornes -> Dracaufeu
R7 : Dracaufeu /\ FlammeBl -> MegDracX
R8 : Dracaufeu /\ TroisCornes -> MegDracY
On peut ajouter le lien entre les variables :

R9 : Troiscornes -> Aumoins2Cornes
R10 : Troiscornes <-> ¬UneCorne
R11 : Aumoins2Cornes <-> ¬UneCorne
R12 : FlammeBl -> FlammeQ

## Question 2 :
Chainage avant

La créature observé, en considérant l'ensemble des faits est celle obtenu en dernier donc un Méga-Dracaufeu Y.

## Question 3 :
Chainage arrière

Il y a trois questions (notés avec ? dans la figure) :

Est-ce qu'il y a une flamme sur la queue ?
Est-ce qu'il y a une forme de dragon ?
Est-ce qu'il y a au moins deux cornes ?