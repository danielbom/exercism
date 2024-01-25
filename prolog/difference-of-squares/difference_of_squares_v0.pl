square_of_sum(N, Result) :-
  aggregate_all(sum(X), (between(1, N, X)), Sum),
  Result is Sum * Sum.

sum_of_squares(N, Result) :-
  aggregate_all(sum(Y), (between(1, N, X), Y is X * X), Result).

difference(N, Result) :-
  square_of_sum(N, SquareOfSum),
  sum_of_squares(N, SumOfSquares),
  Result is SquareOfSum - SumOfSquares.

