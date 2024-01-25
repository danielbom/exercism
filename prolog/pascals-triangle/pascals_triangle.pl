pascal_transform([Fst ,Snd | Tail], [Next | NextResult]) :-
  Next is Fst + Snd,
  pascal_transform([Snd | Tail], NextResult), !.
pascal_transform(_, [1]).

reversed_pascal(0, []) :- !.
reversed_pascal(1, [[1]]) :- !.
reversed_pascal(NumRows, [[1 | NextResult], Last | PreviousRows]) :-
  PreviousNumRows is NumRows - 1,
  reversed_pascal(PreviousNumRows, [Last | PreviousRows]),
  pascal_transform(Last, NextResult).

pascal(NumRows, Rows) :-
  reversed_pascal(NumRows, ReversedRows),
  reverse(ReversedRows, Rows).
