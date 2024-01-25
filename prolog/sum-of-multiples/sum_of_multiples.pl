is_divisible(X, Y) :- 0 is X mod Y.

sum_of_multiples(Factors, Limit, Sum) :-
  Max is Limit - 1,
  aggregate_all(sum(X), (between(1, Max, X), include(is_divisible(X), Factors, [_|_])), Sum).
