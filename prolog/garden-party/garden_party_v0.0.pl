:- use_module(library(clpfd)).

beverage(Chef, Beverage) :-
  table(Table),
  member((Chef, _, Beverage), Table),
  !.

dish(Chef, Dish) :-
  table(Table),
  member((Chef, Dish, _), Table),
  !.

table(Table) :- 
  Chefs = [aisha, emma, mei, winona],
  Dishes = [pad_thai, frybread, tagine, biryani],
  Beverages = [tonic, lassi, kombucha, amasi],
  create_table(Chefs, Dishes, Beverages, Table),
  member((aisha, tagine, _), Table), % 1
  member((emma, _, amasi), Table), % 2
  member((_, frybread, tonic), Table), % 3
  member((mei, _, lassi), Table), % 4
  \+ member((winona, pad_thai, _), Table), % 5
  \+ member((_, biryani, lassi), Table), % 6
  true.

create_table([Chef | Chefs], Dishes, Beverages, [(Chef, Dish, Beverage) | Table]) :-
  member(Dish, Dishes), exclude(=(Dish), Dishes, NextDishes),
  member(Beverage, Beverages), exclude(=(Beverage), Beverages, NextBeverages),
  create_table(Chefs, NextDishes, NextBeverages, Table).
create_table([], [], [], []).
