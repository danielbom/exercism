:- use_module(library(clpfd)).

combinations(Size, Sum, Exclude, Combinations) :-
  findall(Combination, (combination(Size, Sum, Exclude, Combination)), Combinations).

combination(Size, Sum, Exclude, Combination) :-
  length(Combination, Size),
  Combination ins 1..9,
  maplist(exclude_all(Exclude), Combination),
  ascending(Combination),
  sum(Combination, #=, Sum),
  intersection(Combination, Exclude, []),
  label(Combination).

exclude_all([], _).
exclude_all([Y | Exclude], X) :-
  X #\= Y,
  exclude_all(Exclude, X).

ascending([]).
ascending([_]).
ascending([X, Y | Tail]) :-
  X #< Y,
  ascending([Y | Tail]).
