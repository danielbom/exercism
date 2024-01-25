floor(Name, Floor) :-
  floors(Floors),
  nth0(Floor0, Floors, Name),
  succ(Floor0, Floor),
  !.

floors(Floors) :-
  Residents = [amara, bjorn, cora, dale, emiko],
  same_length(Residents, Floors), % 1
  permutation(Residents, Floors), % 2
  nth0(NthAmara, Floors, amara),
  nth0(NthBjorn, Floors, bjorn),
  nth0(NthCora, Floors, cora),
  nth0(NthDale, Floors, dale),
  nth0(NthEmiko, Floors, emiko),
  NthAmara =\= 4, % 3,
  NthBjorn =\= 0, % 4,
  NthCora =\= 4, NthCora =\= 0, % 5
  NthDale > NthBjorn, % 6
  NthEmiko + 1 =\= NthCora, NthEmiko - 1 =\= NthCora, % 7
  NthCora + 1 =\= NthBjorn, NthCora - 1 =\= NthBjorn % 8
  .
