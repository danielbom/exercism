maximum_value(Items, Capacity, Value) :- 
  valid_items(Items, Capacity),
  % This is a relatively efficient and relatively intuitive way to find the maximum. Interesting
  % comparison here: https://www.reddit.com/r/prolog/comments/2ym5o5/smallestbiggest_of_given_facts/
  % Funnily enough, the tests actually pass with the aggregation (just make_dumb_bag will do!)
  % because they just look for the right answer and only throw a "Test succeeded with choicepoint"
  % if you always return wrong (non-maximmal) answers.
  aggregate(max(Value), make_dumb_bag(Items, Capacity, Value), MaxValue),
  Value = MaxValue.

make_bag([], _, Value) :- Value = 0, !.
make_bag(Items, Capacity, Value) :-
  select(item(Weight, IValue), Items, RItems),
  NCapacity is Capacity - Weight,
  (NCapacity > 0 -> make_bag(RItems, NCapacity, NValue);
   NCapacity < 0 -> NValue is -IValue;
                    NValue is 0),
  Value is NValue + IValue.

% Couldn't find a logical way to include this in make_bag, so do it explicitly here.
valid_items([], _) :- !.
valid_items(Items, Capacity) :-
  select(item(Weight, _), Items, _),
  Weight =< Capacity, !.

% Turns out make_bag was throwing stack overflows with 15 items. What about something a bit
% dumber - instead of permuting all the items, just run through then in order and at each
% item choose to either take it, or skip it. Problem solved...
make_dumb_bag([], _, Value) :- Value = 0, !.
% Take next item
make_dumb_bag([item(Weight, IValue) | Rest], Capacity, Value) :-
  NCapacity is Capacity - Weight,
  (NCapacity > 0 -> make_dumb_bag(Rest, NCapacity, NValue);
   NCapacity < 0 -> NValue = -IValue;
                    NValue = 0),
  Value is NValue + IValue.
% Or don't take next item
make_dumb_bag([_ | Rest], Capacity, Value) :- 
  make_dumb_bag(Rest, Capacity, Value).
