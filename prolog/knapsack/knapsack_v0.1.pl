:- use_module(library(clpfd)).

maximum_value([], _, 0) :- !.
maximum_value(Items, Capacity, Value) :-
  same_length(Items, ItemsUsed),
  maplist([item(W, V), W, V] >> true, Items, ItemsWeights, ItemsValues),
  ItemsUsed ins 0..1,
  Value #> 0,
  scalar_product(ItemsWeights, ItemsUsed, #=<, Capacity),
  scalar_product(ItemsValues, ItemsUsed, #=, Value),
  labeling([max(Value)], ItemsUsed),
  !.
