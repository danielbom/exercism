convert(N, Sounds) :-
  M3 is N mod 3,
  M5 is N mod 5,
  M7 is N mod 7,
  (M3 =:= 0 -> S1 = "Pling"; S1 = ""),
  (M5 =:= 0 -> S2 = "Plang"; S2 = ""),
  (M7 =:= 0 -> S3 = "Plong"; S3 = ""),
  atomics_to_string([S1, S2, S3], S),
  (string_length(S, 0) -> number_string(N, Sounds); Sounds = S).