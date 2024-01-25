% Tab e(color, nationality, pet, beverage, cigarette)
solution(Tab) :-
    length(Tab, 5), % 1
    member(e(red, englishman, _, _, _), Tab), % 2.
    member(e(_, spaniard, dog, _, _), Tab), % 3.
    member(e(green, _, _, coffee, _), Tab), % 4.
    member(e(_, ukrainian, _, tea, _), Tab), % 5.
    next(e(ivory, _, _, _, _), e(green, _, _, _, _), Tab), % 6.
    member(e(_, _, snails, _, old_gold), Tab), % 7.
    member(e(yellow, _, _, _, kools), Tab), % 8.
    Tab = [_, _, e(_, _, _, milk, _), _, _], % 9.
    Tab = [e(_, norwegian, _, _, _), _, _, _, _], % 10.
    next(e(_, _, _, _, chesterfields), e(_, _, fox, _, _), Tab), % 11.
    next(e(_, _, _, _, kools), e(_, _, horse, _, _), Tab), % 12.
    member(e(_, _, _, orange_juice, lucky_strike), Tab), % 13.
    member(e(_, japanese, _, _, parliament), Tab), % 14.
    next(e(_, norwegian, _, _, _), e(blue, _, _, _, _), Tab), % 15.
    member(e(_, _, zebra, _, _), Tab), % zebra exists
    member(e(_, _, _, water, _), Tab). % water exists

next(A, B, List) :- append([_, [A, B], _], List); append([_, [B, A], _], List).

zebra_owner(Z) :- solution(Tab), member(e(_, Z, zebra, _, _), Tab), !.

water_drinker(W) :- solution(Tab), member(e(_, W, _, water, _), Tab), !.
