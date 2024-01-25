beverage(Chef, Beverage) :-
  solve(Table),
  member((Chef, _, Beverage), Table), !.

dish(Chef, Dish) :-
  solve(Table),
  member((Chef, Dish, _), Table), !.

solve(Table) :-
  Table = [(aisha,_,_),(emma,_,_),(mei,_,_),(winona,_,_)],
  % clue 1
  member((aisha, tagine, _), Table),
  % clue 2
  member((emma, _, amasi), Table),
  % clue 3
  member((_, frybread, tonic), Table),
  % clue 4
  member((mei, _, lassi), Table),
  % clue 5
  member((NWinona, pad_thai, _), Table),
  not(NWinona = winona),
  % clue 6
  member((_, biryani,  NotLassi), Table),
  not(NotLassi = lassi),
  % implied
  member((_, _, kombucha), Table).
