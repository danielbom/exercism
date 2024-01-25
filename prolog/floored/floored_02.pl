floor(Name, Floor) :-
  solve(Floors),
  nth1(Floor, Floors, Name), !.

solve(Floors) :- 
  Names = [amara, bjorn, cora, dale, emiko],
  permutation(Names, Floors),
  nth1(FloorAmara, Floors, amara), FloorAmara =\= 5,
  nth1(FloorBjorn, Floors, bjorn), FloorBjorn =\= 1,
  nth1(FloorCora, Floors, cora), FloorCora =\= 1, FloorCora =\= 5,
  nth1(FloorDale, Floors, dale), FloorDale > FloorBjorn,
  nth1(FloorEmiko, Floors, emiko), not_adjacent(FloorEmiko, FloorCora),
  not_adjacent(FloorCora, FloorBjorn), !.

not_adjacent(F1, F2) :- F1 > F2 + 1, !.
not_adjacent(F1, F2) :- F1 < F2 - 1.
