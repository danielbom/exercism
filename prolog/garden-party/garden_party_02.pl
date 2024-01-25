solution(T) :-
    length(T, 4),
    member(bring(aisha, tagine, _), T),
    member(bring(emma, _, amasi), T),
    member(bring(_, frybread, tonic), T),
    member(bring(mei, _, lassi), T),
    member(bring(winona, WinonaDish, _), T),
    WinonaDish \= pad_thai,
    member(bring(LassiChef, _, lassi), T),
    member(bring(BiryaniChef, biryani, _), T),
    LassiChef \= BiryaniChef,
    member(bring(_, _, kombucha), T), % missing drink
    member(bring(_, pad_thai, _), T). % missing dish

beverage(Chef, Beverage) :- 
  solution(T),
  member(bring(Chef, _, Beverage), T),
  !.

dish(Chef, Dish) :-
  solution(T),
  member(bring(Chef, Dish, _), T),
  !.
