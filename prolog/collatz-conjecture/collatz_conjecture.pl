collatz_steps(N, _, _) :- N < 1, !, fail.
collatz_steps(1, Steps, Steps) :- !.
collatz_steps(N, Acc, Steps) :-
  ( 0 is N mod 2 ->
    NextN is N / 2
  ; NextN is N * 3 + 1
  ),
  NextAcc is Acc + 1,
  collatz_steps(NextN, NextAcc, Steps).

collatz_steps(N, Steps) :- collatz_steps(N, 0, Steps).
