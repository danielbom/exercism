:- use_module(library(clpfd)).

floor(Name, Floor) :-
  floors(Floors),
  nth0(Floor0, Floors, Name),
  succ(Floor0, Floor),
  !.

floors(Floors) :-
  Residents = [amara, bjorn, cora, dale, emiko],
  FloorsIx = [NthAmara, NthBjorn, NthCora, NthDale, NthEmiko],
  FloorsIx ins 1..5,              % 1
  all_distinct(FloorsIx),         % 2
  NthAmara #\= 5,                 % 3
  NthBjorn #\= 1,                 % 4
  NthCora #\= 5, NthCora #\= 1,   % 5
  NthDale #> NthBjorn,            % 6
  abs(NthEmiko - NthCora) #\= 1,  % 7
  abs(NthCora - NthBjorn) #\= 1,  % 8
  label(FloorsIx),
  pairs_keys_values(Pairs, FloorsIx, Residents),
  sort(Pairs, SortedPairs),
  pairs_values(SortedPairs, Floors).
