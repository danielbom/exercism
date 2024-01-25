is_divisible(X, Y) :- 0 is X mod Y.

is_divisible_list(X, YS) :- not(include(is_divisible(X), YS, [])).

sum_of_multiples(Factors, Limit, Sum) :-
  Max is Limit - 1,
  aggregate_all(sum(X), (between(1, Max, X), is_divisible_list(X, [3, 5])), Sum).
