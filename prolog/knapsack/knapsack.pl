:- table maximum_value/3.

maximum_value(Items, Capacity, Value) :-
  Capacity > 0,
  convlist(solve_subproblem(Items, Capacity), Items, Solutions),
  max_list(Solutions, Value),
  Value > 0.
maximum_value([], _, 0).
maximum_value(_, 0, 0).

solve_subproblem(Items, Capacity, item(Weight, Value), TotalValue) :-
  Capacity >= Weight,
  SubCapacity is Capacity - Weight,
  select(item(Weight, Value), Items, SubItems),
  (maximum_value(SubItems, SubCapacity, SubValue) -> 
    TotalValue is Value + SubValue
  ; TotalValue is Value
  ).
solve_subproblem(_, _, _, 0).
