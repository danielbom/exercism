convert(N, Sounds) :-
  Divisors = [3-"Pling", 5-"Plang", 7-"Plong"],
  convlist(apply_factor(N), Divisors, FactorsSounds),
  (FactorsSounds = [] ->
    atomics_to_string(FactorsSounds, Sounds),
  ; number_string(N, Sounds)
  ).

apply_factor(N, Factor-String, String) :-
    0 is N mod Factor.
