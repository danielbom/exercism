:- use_module(library(lists)).
:- use_module(library(clpfd)).

combinations(Size, Sum, Exclude, Combinations) :-
  length(Nums, Size),
  sum(Nums, #=, Sum),
  Nums ins 1..9,
  append(Nums, Exclude, Combination),
  all_distinct(Combination),
  sort(Nums),
  findall(Nums, label(Nums), Combinations), !.

sort([_]).
sort([Head | Tail]) :- Tail = [First | _], Head #< First, sort(Tail).