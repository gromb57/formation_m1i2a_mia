% Coloriage d’une carte planaire

% En tant que graphiste,
% il nous faut colorier une carte de n régions de telle sorte que deux régions adjacentes ne soient pas de la même couleur,
% afin de bien mettre en évidence les différentes frontières
% Un théorème montre que toute carte planaire est coloriable avec au plus 4 couleurs de base.

% Après avoir modélisé la carte en Prolog par un système d’adjacence,
% il suffit de tenter un coloriage avec une couleur, puis deux,...
% Pour ce faire, on colorie une à une les régions en prenant garde
% à chaque fois que la contrainte évoquée plus haut est respectée.
% Lorsque toutes les régions ont pu être coloriées,
% la couleur de chacune d’elles est affichée à l’écran sous forme textuelle.

adjacent(NordPasDeCalais, Picardie).
adjacent(Picardie, NordPasDeCalais).
adjacent(Picardie, ChampagneArdennes).
adjacent(Picardie, HauteNormandie).
adjacent(Picardie, IleDeFrance).
adjacent(ChampagneArdennes, Picardie).
adjacent(ChampagneArdennes, Lorraine).
adjacent(ChampagneArdennes, FrancheComte).
adjacent(ChampagneArdennes, Bourgogne).
adjacent(ChampagneArdennes, IleDeFrance).
adjacent(Lorraine, ChampagneArdennes).
adjacent(Lorraine, Alsace).
adjacent(Lorraine, FrancheComte).
adjacent(Alsace, Lorraine).
adjacent(Alsace, FrancheComte).
adjacent(HauteNormandie, Picardie).
adjacent(HauteNormandie, IleDeFrance).
adjacent(HauteNormandie, BasseNormandie).
adjacent(HauteNormandie, Centre).
adjacent(IleDeFrance, Picardie).
adjacent(IleDeFrance, HauteNormandie).
adjacent(IleDeFrance, ChampagneArdennes).
adjacent(IleDeFrance, Centre).
adjacent(IleDeFrance, Bourgogne).
adjacent(BasseNormandie, HauteNormandie).
adjacent(BasseNormandie, Centre).
adjacent(BasseNormandie, Bretagne).
adjacent(BasseNormandie, PaysDeLoire).
adjacent(Bretagne, HauteNormandie).
adjacent(Bretagne, PaysDeLoire).
adjacent(PaysDeLoire, Bretagne).
adjacent(PaysDeLoire, BasseNormandie).
adjacent(PaysDeLoire, Centre).
adjacent(PaysDeLoire, PoitouCharentes).
adjacent(Centre, BasseNormandie).
adjacent(Centre, HauteNormandie).
adjacent(Centre, IleDeFrance).
adjacent(Centre, Bourgogne).
adjacent(Centre, Auvergne).
adjacent(Centre, PoitouCharentes).
adjacent(Centre, PaysDeLoire).
adjacent(Bourgogne, IleDeFrance).
adjacent(Bourgogne, ChampagneArdennes).
adjacent(Bourgogne, FrancheComte).
adjacent(Bourgogne, RhoneAlpes).
adjacent(Bourgogne, Auvergne).
adjacent(Bourgogne, Centre).
adjacent(FrancheComte, ChampagneArdennes).
adjacent(FrancheComte, Lorraine).
adjacent(FrancheComte, Alsace).
adjacent(FrancheComte, RhoneAlpes).
adjacent(FrancheComte, Bourgogne).
adjacent(PoitouCharentes, PaysDeLoire).
adjacent(PoitouCharentes, Centre).
adjacent(PoitouCharentes, Limousin).
adjacent(PoitouCharentes, Aquitaine).
adjacent(Limousin, PoitouCharentes).
adjacent(Limousin, Centre).
adjacent(Limousin, Auvergne).
adjacent(Limousin, MidiPyrenees).
adjacent(Limousin, Aquitaine).
adjacent(Auvergne, Limousin).
adjacent(Auvergne, Centre).
adjacent(Auvergne, Bourgogne).
adjacent(Auvergne, RhoneAlpes).
adjacent(Auvergne, LanguedocRoussillon).
adjacent(Auvergne, MidiPyrenees).
adjacent(RhoneAlpes, Auvergne).
adjacent(RhoneAlpes, Bourgogne).
adjacent(RhoneAlpes, FrancheComte).
adjacent(RhoneAlpes, PACA).
adjacent(RhoneAlpes, LanguedocRoussillon).
adjacent(Aquitaine, PoitouCharentes).
adjacent(Aquitaine, Limousin).
adjacent(Aquitaine, MidiPyrenees).
adjacent(MidiPyrenees, Aquitaine).
adjacent(MidiPyrenees, Limousin).
adjacent(MidiPyrenees, Auvergne).
adjacent(MidiPyrenees, LanguedocRoussillon).
adjacent(LanguedocRoussillon, MidiPyrenees).
adjacent(LanguedocRoussillon, Auvergne).
adjacent(LanguedocRoussillon, RhoneAlpes).
adjacent(LanguedocRoussillon, PACA).
adjacent(PACA, LanguedocRoussillon).
adjacent(PACA, RhoneAlpes).
adjacent(PACA, Corse).
adjacent(Corse, PACA).

coloriage(Couleur,Rep):-
    colorie([Alsace,Aquitaine,Auvergne,Bourgogne,Bretagne,Centre,
             ChampagneArdennes,Corse,FrancheComte,IleDeFrance,
             LanguedocRoussillon,Limousin,Lorraine,MidiPyrennees,
             NordPasDeCalais,BasseNormandie,HauteNormandie,
             PaysDeLoire,Picardie,PoitouCharentes,
             PACA,RhoneAlpes],Couleur,[],Rep),
    nl,
    write('La reponse est :'), % permet de d'afficher du texte dans la console
    nl,
    write(Rep), % permet de d'afficher de la liste complète dans la console
    nl.

colorie(_,_,Rep,Rep). % Lorsque toutes les régions ont été coloriées (Argument 1 = vide),
                       % l'accumulateur (Argument 3) constitue la réponse (Argument 4)
colorie([R|Region],Couleur,Acc,Rep):-  % Pour chaque région à colorier
    adjacent(R,Adj), % on récupère les régions adjacentes
    member(C,Couleur), % on choisit une couleur
    verifie_couleur(Adj,C,Acc), % on teste la couleur choisie en fonction des régions déjà coloriées
    colorie(Region,Couleur,[[R,C]|Acc],Rep).  % on lance récursivement le
                                        % traitement sur les autres régions
                                        % en ajoutant à l'accumulateur le
                                        % nouveau couple région-couleur
    
verifie_couleur([],_,_).
verifie_couleur([A|Adj],C,Acc):-
    \+member([A,C],Acc),
    verifie_couleur(Adj,C,Acc).
    