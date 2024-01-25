hamming_distance_list([], [], 0).
hamming_distance_list([Code1|Rest1], [Code2|Rest2], Distance) :-
  hamming_distance_list(Rest1, Rest2, NextDistance),
  (Code1 =\= Code2 ->
    Distance is NextDistance + 1
  ; Distance is NextDistance
  ), !.

hamming_distance(String1, String2, Distance) :-
  string_codes(String1, Codes1),
  string_codes(String2, Codes2),
  length(Codes1, Length),
  length(Codes2, Length),
  hamming_distance_list(Codes1, Codes2, Distance).
