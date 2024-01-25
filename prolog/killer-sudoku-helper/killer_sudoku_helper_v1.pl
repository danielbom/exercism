combinations(Size, Sum, Exclude, Combinations) :-
  findall(X, (between(1, 9, X), not(member(X, Exclude))), Valids),
  findall(Combination, combination(Size, Sum, Valids, Combination), Combinations).

combination(1, Sum, Valids, [Sum]) :-
  member(Sum, Valids).
combination(Size, Sum, Valids, [X | Xs]) :-
  Size > 1,
  member(X, Valids),
  NextSize is Size - 1,
  NextSum is Sum - X,
  findall(Y, (member(Y, Valids), Y > X), NextValids),
  combination(NextSize, NextSum, NextValids, Xs).
