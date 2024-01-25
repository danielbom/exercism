convert(N, Sounds) :-
    include(is_factor_of(N), [3, 5, 7], Factors),
    maplist(factor_to_sound, Factors, SoundList),
    foldl(concat_string, SoundList, "", Acc),
    (Acc == "" -> number_string(N, Sounds); Sounds = Acc).

is_factor_of(N, X) :- N mod X =:= 0.

factor_to_sound(3, "Pling").
factor_to_sound(5, "Plang").
factor_to_sound(7, "Plong").

concat_string(String, Acc, NewAcc) :-
  string_concat(Acc, String, NewAcc).
