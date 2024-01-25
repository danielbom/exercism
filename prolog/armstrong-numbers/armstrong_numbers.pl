armstrong_number(Num) :-
  atom_number(Str, Num),
  string_chars(Str, Chars),
  length(Chars, N),
  aggregate_all(sum(X), (member(C, Chars), atom_number(C, K), X is K ** N), Num).
