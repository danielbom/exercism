combinations(Size, Sum, Exclude, Combinations) :-
  findall(X, (between(1, 9, X), not(member(X, Exclude))), Valids),
  findall(Combination, combination(Size, Sum, Valids, Combination), Combinations).

combination(1, Sum, Valids, [Sum]) :-
  member(Sum, Valids), !.
combination(Size, Sum, [X | NextValids], [X | Xs]) :-
  Size > 1,
  NextSize is Size - 1,
  NextSum is Sum - X,
  combination(NextSize, NextSum, NextValids, Xs).
combination(Size, Sum, [_ | NextValids], Xs) :-
  combination(Size, Sum, NextValids, Xs).

