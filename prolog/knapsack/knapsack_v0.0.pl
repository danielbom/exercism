:- use_module(library(clpfd)).

maximum_value([], _, 0) :- !.
maximum_value(Items, Capacity, Value) :-
  length(Items, ItemsCount),
  length(ItemsUsed, ItemsCount),
  maplist([item(W, V), W, V] >> true, Items, ItemsWeights, ItemsValues),
  Value #> 0,
  Capacity #>= 0,
  ItemsUsed ins 0..1,
  scalar_product(ItemsWeights, ItemsUsed, #=<, Capacity),
  scalar_product(ItemsValues, ItemsUsed, #=, Value),
  labeling([max(Value)], ItemsUsed), !.
