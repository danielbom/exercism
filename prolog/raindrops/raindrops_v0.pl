convert(N, Sounds) :-
  findall(Sound, (number_sound(N, Sound)), FactorsSounds),
  (length(FactorsSounds, 0) ->
    number_string(N, Sounds)
  ; string_concat_all(FactorsSounds, Sounds)
  ).

number_sound(N, "Pling") :- 0 is N mod 3.
number_sound(N, "Plang") :- 0 is N mod 5.
number_sound(N, "Plong") :- 0 is N mod 7.

string_concat_all(Strings, Result) :-
  string_concat_all(Strings, "", Result).
string_concat_all([], Result, Result).
string_concat_all([S | Rest], Acc, Result) :-
  string_concat(Acc, S, NextAcc),
  string_concat_all(Rest, NextAcc, Result).