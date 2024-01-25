:- use_module(library(lists)).

zero(Z) :- char_code("0", Z).
one(O) :- char_code("1", O).

binary(Str, Dec) :-
  string_to_list(Str, BinaryList),
  reverse(BinaryList, Reversed),
  phrase(convert_binary(Reversed), [Dec]),
  !.

convert_binary(BinaryList) --> convert_binary(BinaryList, 1, 0).
convert_binary([], _Value, Acc) --> [Acc].
convert_binary([Z | Tail], Value, Acc) --> { zero(Z) },
                                           { NextValue is Value * 2 },
                                           convert_binary(Tail, NextValue, Acc).
convert_binary([O | Tail], Value, Acc) --> { one(O) },
                                           { NextValue is Value * 2 },
                                           { NextAcc is Acc + Value },
                                           convert_binary(Tail, NextValue, NextAcc).
