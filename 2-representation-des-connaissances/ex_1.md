# Traduction

Soient les phrases suivantes :
1. Les étudiants sont jeunes.
2. Les jeunes sont célibataires.
3. Les célibataires sont jeunes.
4. Une partie des jeunes sont étudiants.
5. Les étudiants ayant des enfants sont mariés ou concubins.
6. Les concubins sont jeunes.
7. On ne peut pas être simultanément célibataire, marié ou concubin.

## 1. logique propositionnelle

1. Les étudiants sont jeunes.
`etudiants→jeunes`
2. Les jeunes sont célibataires.
`jeunes→célibataires`
3. Les célibataires sont jeunes.
`célibataires→jeunes`
4. Une partie des jeunes sont étudiants.
`jeunes→étudiants`
5. Les étudiants ayant des enfants sont mariés ou concubins.
`(étudiant ∧ enfant)→(mariés ∨ concubins)`
6. Les concubins sont jeunes.
`concubins→jeunes`
7. On ne peut pas être simultanément célibataire, marié ou concubin.
- `célibataire→(¬marié ∧ ¬concubin)`
- `marié(¬célibataire→ ∧ ¬concubin)`
- `concubin→(¬célibataire ∧ ¬marié)`

"Fabrice est jeune ?"  
- `fabrice→étudiant`
- `fabrice→célibataire`
- `fabrice→¬marié`
- `fabrice→¬concubin`
- `fabrice→¬enfant`

## 2. règles de production

1. Les étudiants sont jeunes.
`si etudiants alors jeunes(0.9)`
2. Les jeunes sont célibataires.
`si jeunes alors célibataires(0.8)`
3. Les célibataires sont jeunes.
`si célibataires alors jeunes(0.7)`
4. Une partie des jeunes sont étudiants.
`si jeunes alors étudiants(0.3)`
5. Les étudiants ayant des enfants sont mariés ou concubins.
`si étudiant et sans enfant alors mariés ou concubins(0.95)`
6. Les concubins sont jeunes.
`si concubins alors jeunes(0.8)`
7. On ne peut pas être simultanément célibataire, marié ou concubin.
- `si célibataire alors marié(-1))`
- `si célibataire alors concubin(-1))`
- `si concubin alors célibataire(-1))`
- `si concubin alors marié(-1))`
- `si marié alors célibataire(-1))`
- `si marié alors concubin(-1))`

"Fabrice est jeune ?"
- `étudiant(0.9)`
- `concubins(0.8)`
- `célibataire(0.7)`

## 3. logique des prédicats.

1. Les étudiants sont jeunes.
`∀ x (etudiants(x) → jeunes(x)`
2. Les jeunes sont célibataires.
`∀ x (jeunes(x) → célibataires(x)`
3. Les célibataires sont jeunes.
`∀ x (célibataires(x) → jeunes(x))`
4. Une partie des jeunes sont étudiants.
`∃ x (jeunes(x) → étudiants(x))`
5. Les étudiants ayant des enfants sont mariés ou concubins.
`∀ x (etudiants(x) ∧ enfants(x) → (mariés(x) ∨ concubins(x)))`
6. Les concubins sont jeunes.
`∀ x (concubins(x) → jeunes(x))`
7. On ne peut pas être simultanément célibataire, marié ou concubin.
- `∀ x (célibataire(x) → ¬marié(x) ∧ ¬concubin(x))`
- `∀ x (marié(x) → ¬célibataire(x) ∧ ¬concubin(x))`
- `∀ x (concubin(x) → ¬célibataire(x) ∧ ¬marié(x))`

"Fabrice est un étudiant qui vit en concubinage ?"
- `etudiant(fabrice) → jeune(fabrice)`
- `concubinage(fabrice) → jeune(fabrice)`
- `jeune(fabrice) → célibataire(fabrice)`
- `etudiant(fabrice) ∧ concubinage(fabrice) → enfant(fabrice)`
- `concubinage(fabrice) → ¬célibataire(fabrice)`
- `concubinage(fabrice) → ¬marié(fabrice)`

Ceci est contradictoire donc il faut gérer le problème pour cela, il existe plusieurs solu-
tions pour modéliser cette exception :
1. On peut réécrire les affirmations pour y incorporer l’information sur l’individu dé- viant :
1) ∀ x ((étudiant(x) ∧ x ̸= Fabrice) −→ jeune(x)) 6) ∀ x ((concubin(x) ∧ x ̸= Fabrice) −→ jeune(x)) 2) ∀ x ((Jeune(X) ∧ x ̸= Fabrice) −→ célibataire(x))
2. ou plus général 2) ∀ ((Jeune(X) ∧ ¬ concubin(x)) −→ célibataire(x))

## 4. logique des défauts

1. Les étudiants sont jeunes.
`étudiant(x) : jeune(x) / jeune(x)`
2. Les jeunes sont célibataires.
`jeune(x) : célibataire(x) / célibataire(x)`
3. Les célibataires sont jeunes.
`célibataire(x) : jeune(x) / jeune(x)`
4. Une partie des jeunes sont étudiants.
`jeune(x) : étudiant(x) / étudiant(x)`
`jeune(x) : ¬étudiant(x) / ¬étudiant(x)`
5. Les étudiants ayant des enfants sont mariés ou concubins.
`etudiant(x) ∧ enfant(x) : marié(x) ∨ concubin(x) / marié(x) ∨ concubin(x)`
6. Les concubins sont jeunes.
`concubin(x) : jeune(x) / jeune(x)`
7. On ne peut pas être simultanément célibataire, marié ou concubin.
- `célibataire(x) : ¬marié(x) ∧ ¬concubin(x) / ¬marié(x) ∧ ¬concubin(x)`
- `marié(x) : ¬célibataire(x) ∧ ¬concubin(x) / ¬célibataire(x) ∧ ¬concubin(x)`
- `concubin(x) : ¬célibataire(x) ∧ ¬marié(x) / ¬célibataire(x) ∧ ¬marié(x)`

a."Fabrice est étudiant, quel est son statut marital ?"
- `étudiant(fabrice) : jeune(fabrice) / jeune(fabrice)`
- `jeune(fabrice) : célibataire(fabrice) / célibataire(fabrice)`

b."Fabrice est étudiant et a peut-être des enfants, quel est son statut marital ?"
- `étudiant(fabrice) : jeune(fabrice) / jeune(fabrice)`
- `jeune(fabrice) : célibataire(fabrice) / célibataire(fabrice)`
- `etudiant(fabrice) ∧ enfant(fabrice) : marié(fabrice) ∨ concubin(fabrice) / marié(fabrice) ∨ concubin(fabrice)`

Contradiction :
`jeune(x) ∧ ¬enfant(x)  : célibataire(x) / célibataire(x)`
