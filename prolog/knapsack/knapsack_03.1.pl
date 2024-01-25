maximum_value(Items, Capacity, Value) :- 
  valid_items(Items, Capacity),
  aggregate(max(Value), make_dumb_bag(Items, Capacity, Value), MaxValue),
  Value = MaxValue.

valid_items([], _) :- !.
valid_items(Items, Capacity) :-
  select(item(Weight, _), Items, _),
  Weight =< Capacity, !.

make_dumb_bag([], _, Value) :- Value = 0, !.
make_dumb_bag([item(Weight, IValue) | Rest], Capacity, Value) :-
  NCapacity is Capacity - Weight,
  (NCapacity > 0 -> make_dumb_bag(Rest, NCapacity, NValue);
   NCapacity < 0 -> NValue = -IValue;
                    NValue = 0),
  Value is NValue + IValue.
make_dumb_bag([_ | Rest], Capacity, Value) :- 
  make_dumb_bag(Rest, Capacity, Value).
