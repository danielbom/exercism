is_divisible(X, Y) :- R is X mod Y, R == 0.

is_divisible_list(X, YS) :- \+ include(is_divisible(X), YS, []).

sum_of_multiples(Factors, Limit, Sum) :-
  succ(Max, Limit),
  findall(X, (between(1, Max, X), is_divisible_list(X, Factors)), Xs),
  sumlist(Xs, Sum).
