# Exercice 2

## 1. En utilisant les prédicats précédemment définis, donner la traduction en logique des prédicats de F1, F2, F3.
F1 : `∃ x A(S(x), C(x))`
F2 : `∀ x A(¬S(x), E(x))`
F3 : `∀ x (¬C(x) → E(x))`

## 2. Même question en utilisant la logique des défauts
F1 :
    - `A(S(x), C(x)) : A(S(x), C(x)) / A(S(x), C(x))`
    - `A(S(x), C(x)) : ¬A(S(x), C(x)) / ¬A(S(x), C(x))`
F2 :
    - `A(¬S(x), E(x)) : A(¬S(x), E(x)) / A(¬S(x), E(x))`
F3 : `(¬C(x) → E(x)) : (¬C(x) → E(x)) / (¬C(x) → E(x))`

## 3. Calculer les extensions sachant que Fabrice est un supporter qui a assisté au match de coupe Besançon contre Marseille.

1. Fabrice est un supporter
`S(fabrice)`

2. Fabrice est un supporter qui a assisté au match de coupe
`A(S(fabrice), C(x))`

3. Fabrice est un supporter qui a assisté au match de coupe Besançon contre Marseille
`A(S(fabrice), C(Besançon, Marseille))`

4. Fabrice n'a pas asssité à un match sans enjeux
`¬A(S(fabrice), E(x))`

