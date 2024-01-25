string_reverse(S, Reversed) :-
  string_codes(S, Codes),
  reverse(Codes, CodesReversed),
  string_codes(Reversed, CodesReversed).
