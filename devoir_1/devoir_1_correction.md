Correction du devoir n°1
Exercice 1 Prolog : 
Question 1 Prédicat creerPal :
Il fallait faire attention à ne pas doubler la lettre du milieu.

% Cas particulier où l'on appelle avec la liste vide
creerPal([],[]).

% Cas Terminal, il n'y a plus qu'un élément. Il faut bien penser au cut sinon on aura une autre solution avec la lettre centrale doublée.
creerPal([X],[X]):-!.

% Cas Nominal, on explore chaque élément de la liste et on l'ajoute à la fin et au début.
creerPal([X|L],[X|RF]):-
        creerPal(L,R),
        ajout_fin(X,R,RF).

Variante pour les amateurs d'accumulateur :

% Prédicat principal avec le traitement des 2 cas particuliers
creerPal([],[]).
creerPal([X],[X]).
% Prédicat d'appel à la version avec l'accumulateur 
creerPal(L,R):-
        creerPalAcc(L,[],R).

% Traitement avec l'accumulateur
creerPalAcc([],[_|Acc],Acc).
creerPalAcc([X|L],Acc,[X|R]):-
        creerPalAcc(L,[X|Acc],R).
    

Question 2 - Prédicat extrait :
%1er cas terminal : la liste vide
extrait([],[]).
% 2eme cas terminal : la liste est réduite à 1 élément
extrait([X],[X]).
% Cas général, on élimine un élément sur 2 de la liste.
extrait([X,_|L],[X|R]):-
    extrait(L,R).

Variante avec un compteur :

 % On appelle le prédicat avec 3 arguments en initialisant le compteur à traiter.
extrait(L,R):-
        extrait(0,L,R).

% Cas terminal, on a explore toute la liste
extrait(_,[],[]). 

% Cas pair, on garde la valeur de la liste et on la remet dans le résultat R
extrait(0,[X|L],[X|R]):-
        extrait(1,L,R).

 % Cas impair, on ne veux pas garder l'élément de la liste.
extrait(1,[_|L],R):-
        extrait(0,L,R).

Variante sans compteur :

% Cas terminal de la liste vide, on n'a qu'un cas terminal car la liste de 1 élément est gérée dans le cas particulier du elimine2/2
extrait([],[]).

% Cas général, on appelle le prédicat elimine2 qui élimine de L le premier élément et renvoi L1
extrait([X|L],[X|R]):-
        elimine2(L,L1),
        extrait(L1,R).

% Cas particulier de la liste vide
elimine2([],[]).
% Elimination du 2eme élément
elimine2([X|L],L).

Exercice 2 
Question 1 :
F1 : ∃x  S(x) /\ ∀y C( y) -> A(x,y)
F2 : ∀x  S(x) /\ ∀y E( y) -> ¬A(x,y)
F3 : ∀y C( y) -> ¬ E( y)
Question 2 :
F1a : 	
S(x) /\ C( y )

:

A(x,y)

A(x,y)


On peut écrire aussi écrire soit F1b ou soit F1c, si on considère que les non supporters assistent au match ou alors les supporters n'assistent pas au match :
F1b : 	
¬S(x) /\ C( y )

:

A(x,y)

   	F1c : 	
S(x) /\ C( y )

:

¬A(x,y)

A(x,y)

¬A(x,y)

F2 : 	
S(x) /\ E( y )

:

¬A(x,y)

¬A(x,y)

F3 : 	
C( y )

:

¬E( y)

¬E( y)

Question 3 :
Pour ce point, il faut commencer par traduire les informations :

F4 = S(Fabrice) pour "Fabrice est supporter"
F5 = A(Fabrice,Besac_OM) pour "il a assisté au match" 
F6 = C(Besac_OM) pour "un match de coupe" 
On a une théorie telle que T1 =(D={F1a,F1b,F2,F3},W={F4,F5,F6}).

Ainsi il n'y a qu'une extension pour cette théorie. 
A partir de F6 et du défaut F3, on obtient l'information ¬E(Besac_OM). On a donc que le match Besançon - OM est un match avec enjeu.

Exercice 3
Question 1 :
depart(maison).
arrivee(musee).

lieu(banque,250,310).
lieu(battant,210,340).
lieu(beauxarts,460,420).
lieu(boulangerie,380,210).
lieu(cinema,400,240).
lieu(college,220,210).
lieu(edf,630,90).
lieu(hopital,80,0).
lieu(lycee,780,200).
lieu(mairie,300,120).
lieu(maison,120,420).
lieu(musee,500,70).
lieu(republique,580,400).
lieu(veil,0,25).

chemin(banque,battant,40).
chemin(banque,boulangerie,180).
chemin(banque,cinema,200).
chemin(banque,college,40).
chemin(battant,maison,100).
chemin(battant,veil,240).
chemin(beauxarts,cinema,80).
chemin(beauxarts,republique,140).
chemin(boulangerie,mairie,80).
chemin(boulangerie,musee,160).
chemin(boulangerie,republique,220).
chemin(college,hopital,160).
chemin(college,mairie,30).
chemin(edf,lycee,170).
chemin(edf,musee,140).
chemin(hopital,veil,90).
chemin(lycee,republique,240).

route(X,Y,C):- chemin(X,Y,C).
route(X,Y,C):- chemin(Y,X,C).

cout(C,Cout):- 
   arrivee(A), 
   lieu(A,XA,YA), 
   lieu(C,XC,YC), 
   X is XC-XA,
   Y is YC-YA,
   Cout is sqrt((X*X)+(Y*Y)). % Si on prend la racine carré ici, il faut le faire pour distance

distance([_],0).
distance([X,Y|L],G):-
  distance([Y|L],G1),
  route(X,Y,G2),
  G is G1+G2. % Si on prend la racine carré, il faut le faire pour cout aussi 
deplace([C_ini|Parcours],[C_fin,C_ini|Parcours],Cout):- 
   route(C_ini,C_fin, _),
   \+ element(C_fin,Parcours),
   cout(C_fin,Cout1), 
   distance([C_fin,C_ini|Parcours],Cout2),
   Cout is Cout1+Cout2. 

Question 2 :
Parcours avec heuristique :
Le résultat des calculs des chemins :
[[450.0,[musee,boulangerie,mairie,college,banque,battant,maison]],[504.3908891458577,[boulangerie,banque,battant,maison]],[537.2308292331602,[cinema,banque,battant,maison]],[765.7933771208754,[hopital,college,banque,battant,maison]],[842.0209158989294,[veil,battant,maison]],[849.5585369269929,[republique,boulangerie,mairie,college,banque,battant,maison]]]
Le résultat final :
R = [maison,battant,banque,college,mairie,boulangerie,musee] 

Parcours en largeur :
Le résultat des calculs des chemins :[[republique,boulangerie,banque,battant,maison],[musee,boulangerie,banque,battant,maison],[mairie,boulangerie,banque,battant,maison],[beauxarts,cinema,banque,battant,maison],[mairie,college,banque,battant,maison],[hopital,college,banque,battant,maison],[college,hopital,veil,battant,maison]]Le résultat final :
R = [maison,battant,banque,boulangerie,musee]
Parcours en profondeur :
Le résultat final :
R = [maison,battant,veil,hopital,college,mairie,boulangerie,musee]