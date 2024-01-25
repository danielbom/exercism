convert(N, Numeral) :-
  convert_list(N, NumeralList),
  atomics_to_string(NumeralList, Numeral).

convert_list(N, ["M" | Numeral]) :- next_convert(N, Numeral, 1000), !.
convert_list(N, ["C", "M" | Numeral]) :-  next_convert(N, Numeral, 900), !.
convert_list(N, ["D" | Numeral]) :- next_convert(N, Numeral, 500), !.
convert_list(N, ["C", "D" | Numeral]) :-  next_convert(N, Numeral, 400), !.
convert_list(N, ["C" | Numeral]) :- next_convert(N, Numeral, 100), !.
convert_list(N, ["X", "C" | Numeral]) :-  next_convert(N, Numeral, 90), !.
convert_list(N, ["L" | Numeral]) :-  next_convert(N, Numeral, 50), !.
convert_list(N, ["X", "L" | Numeral]) :-  next_convert(N, Numeral, 40), !.
convert_list(N, ["X" | Numeral]) :- next_convert(N, Numeral, 10), !.
convert_list(N, ["I", "X" | Numeral]) :-  next_convert(N, Numeral, 9), !.
convert_list(N, ["V" | Numeral]) :- next_convert(N, Numeral, 5), !.
convert_list(N, ["I", "V" | Numeral]) :-  next_convert(N, Numeral, 4), !.
convert_list(N, ["I" | Numeral]) :- next_convert(N, Numeral, 1), !.
convert_list(0, []) :- !.

next_convert(N, Numeral, X) :- N >= X, !, NextN is N - X, convert_list(NextN, Numeral).
