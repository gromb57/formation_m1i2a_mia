# Sportifs

Soient les règles suivantes :
- R1 : les étudiants sont jeunes.
- R2 : les jeunes font du foot.
- R3 : le foot est pratiqué par des jeunes.
- R4 : une partie des jeunes sont étudiants.
- R5 : les étudiants qui gagnent font de la belote ou de la pétanque.
- R6 : les joueurs de belote sont jeunes.
- R7 : on ne peut pas jouer en même temps à la belote, au foot ou à la pétanque.
- R8 : une partie des enseignants sont étudiants

## 1. Donner la traduction des règles à l’aide de la logique des défauts.

- R1 : `etudiants(x) : jeunes(x) / jeunes(x)`
- R2 : `jeunes(x) : foot(x) / foot(x)`
- R3 : `foot(x) : jeunes(x) / jeunes(x)`
- R4 :
    - `jeunes(x) : etudiants(x) / etudiants(x)`
    - `jeunes(x) : ¬etudiants(x) / ¬etudiants(x)`
- R5 : `etudiants(x) ∧ gagnent(x) : belote(x) ∨ pétanque(x) / belote(x) ∨ pétanque(x)`
- R6 : `belote(x) : jeunes(x) / jeunes(x)`
- R7 :
    - `belote(x) : ¬foot(x) ∧ ¬pétanque(x) / ¬foot(x) ∧ ¬pétanque(x)`
    - `foot(x) : ¬belote(x) ∧ ¬pétanque(x) / ¬belote(x) ∧ ¬pétanque(x)`
    - `pétanque(x) : ¬belote(x) ∧ ¬foot(x) / ¬belote(x) ∧ ¬foot(x)`
- R8 :
    - `enseignants(x) : etudiants(x) / etudiants(x)`
    - `enseignants(x) : ¬etudiants(x) / ¬etudiants(x)`

## 2. Calculer toutes les extensions de cette théorie des défauts, sachant que “Fabrice est enseignant”.
- R8a, R1, R2, R3, R4
- R8b, R4

## 3. Calculer toutes les extensions de cette théorie des défauts, sachant que “Fabrice est enseignant, et qu’il a peut être gagné”.
- E3 : enseignant(Fabrice) [R9], ¬étudiant(Fabrice) [R8b], gagne(Fabrice) [R10a].
- E4 : enseignant(Fabrice) [R9], ¬étudiant(Fabrice) [R8b], ¬gagne(Fabrice) [R10b].
- E5 : enseignant(Fabrice) [R9 ], étudiant(Fabrice) [R8a ], jeune(Fabrice) [R1 ], foot(Fabrice) [R2], ¬belote(Fabrice) [R7b], ¬pétanque(Fabrice) [R7c], gagne(Fabrice) [R10a].
- E6 : enseignant(Fabrice) [R9 ], étudiant(Fabrice) [R8a ], jeune(Fabrice) [R1 ], foot(Fabrice) [R2], ¬belote(Fabrice) [R7b], ¬pétanque(Fabrice) [R7c], ¬gagne(Fabrice) [R10b].
- E7 : enseignant(Fabrice) [R9 ], gagne(Fabrice) [R10a ], étudiant(Fabrice) [R8a ], jeune(Fabrice) [R1], belote(Fabrice) [R5a], ¬pétanque(Fabrice) [R7a], ¬foot(Fabrice) [R7b].
- E8 : enseignant(Fabrice) [R9 ], gagne(Fabrice) [R10a ], étudiant(Fabrice) [R8a ], jeune(Fabrice) [R1], pétanque(Fabrice) [R5b], ¬belote(Fabrice) [R7a], ¬foot(Fabrice) [R7c]

## 4. “Est-ce que l’on peut avoir des enseignants qui sont étudiants et qui jouent au foot ?” Calculer les extensions de cette théorie des défauts.

- On peut directement dire que Fabrice correspond à ces éléments et reprendre l’ex- tension E2 de la question 2.
- On rajoute une nouvelle information R11 : "∀ x enseignant(x) ∧ étudiant(x) ∧ foot(x)". On crée ainsi une nouvelle théorie S3=(D,W ∪ 11), avec D = 1,2,3,4,5,6 et W= 7a, 7b, 7c. On obtient une extension :
    - E9 : enseignant(x) [R11], étudiant(x) [R11], foot(x) [R11], ¬belote(x) [R7b], ¬pétanque(x) [R7c], jeune(x) [R1]. Il y a juste un problème ce que l’on n’a pas d’individu iden-
tifié correspondant au profil. Mais on a trouvé un modèle à notre théorie qui autorise des individus avec ce profil.