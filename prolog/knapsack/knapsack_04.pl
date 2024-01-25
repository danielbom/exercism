%maximum_value(Items, Capacity, Value) :-
%	get_total_value_and_weight(Items, 0, _, 0, Totalweight).
%	calc_max_value(Items, Capacity, 0, Totalweight).
%
maximum_value([], _, 0) :- !.
maximum_value(Items, Capacity, Value) :-
	all_valid_knapsacks(Items, Capacity, KnapsackList),
	KnapsackList \= [[]],
	max_val_knapsack(KnapsackList, 0, Value), !.

max_val_knapsack([], MaxValue, MaxValue).
max_val_knapsack([Knapsack|Knapsacks], CurrentValue, MaxValue) :-
	get_total_value(Knapsack, 0, Value),
	Value > CurrentValue,
	max_val_knapsack(Knapsacks, Value, MaxValue).

max_val_knapsack([Knapsack|Knapsacks], CurrentValue, MaxValue) :-
	get_total_value(Knapsack, 0, Value),
	Value =< CurrentValue,
	max_val_knapsack(Knapsacks, CurrentValue, MaxValue).

all_valid_knapsacks(Items, Capacity, KnapsackList) :-
	findall(Knapsack, valid_knapsack(Items, Capacity, Knapsack), KnapsackList).

valid_knapsack(Items, Capacity, Knapsack) :-
	my_subset(Items, Knapsack),
	get_total_weight(Knapsack, 0, W),
	W =< Capacity.

get_total_weight([], TotalWeight, TotalWeight).
get_total_weight([item(W,_)|Items], AccWeight, TotalWeight) :-
	AccWeight1 is W + AccWeight,
	get_total_weight(Items, AccWeight1, TotalWeight).

get_total_value([], TotalValue, TotalValue).
get_total_value([item(_,V)|Items], AccValue, TotalValue) :-
	AccValue1 is AccValue + V,
	get_total_value(Items, AccValue1, TotalValue).

my_subset([], []).
my_subset([E|Tail], [E|Ntail]) :-
	my_subset(Tail, Ntail).
my_subset([_|Tail], Ntail) :-
	my_subset(Tail, Ntail).
