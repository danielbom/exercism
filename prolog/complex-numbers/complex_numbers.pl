real((R, _), R).
imaginary((_, I), I).

conjugate((R, I), (R, CI)) :-
  CI is -I.
abs((R, I), Abs) :-
  Abs is sqrt(R*R + I*I).

add((R1, I1), (R2, I2), (R, I)) :-
  R is R1 + R2,
  I is I1 + I2.
sub((R1, I1), (R2, I2), (R, I)) :-
  R is R1 - R2,
  I is I1 - I2.

mul((R1, I1), (R2, I2), (R, I)) :-
  R is R1 * R2 - I1 * I2,
  I is I1 * R2 + R1 * I2.
div((R1, 0), (R2, 0), (R, 0)) :-
  R is R1 / R2, !.
div((R1, I1), (R2, I2), (R, I)) :-
  R is (R1 * R2 + I1 * I2) / (R2 ** 2 + I2 ** 2),
  I is (I1 * R2 - R1 * I2) / (R2 ** 2 + I2 ** 2).
