binary_rec(_, [], 0).
binary_rec(N, [Ch|Tail], Result) :-
  binary_rec(N - 1, Tail, NextResult),
  ( Ch = '1' -> !, Result is NextResult + 2 ** N
  ; Ch = '0' -> !, Result is NextResult
  ; fail
  ).

binary(String, Decimal) :-
  string_chars(String, Chars),
  length(Chars, N),
  binary_rec(N - 1, Chars, Decimal).