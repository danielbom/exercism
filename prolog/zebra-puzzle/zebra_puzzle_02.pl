houses(Hs) :-
    order(Hs, 0),
    %% color, nationality, animal, beverage, cigarette, position
    member((red, englishman, _, _, _, _), Hs),
    member((_, spaniard, dog, _, _, _), Hs),
    member((green, _, _, coffee, _, GreenPos), Hs),
    member((ivory, _, _, _, _, IvoryPos), Hs),
    succ(IvoryPos, GreenPos),
    member((_, ukrainian, _, tea, _, _), Hs),
    member((_, _, snails, _, old_gold, _), Hs),
    member((yellow, _, _, _, kools, KoolPos), Hs),
    member((_, _, horse, _, _, HorsePos), Hs),
    (succ(KoolPos, HorsePos); succ(HorsePos, KoolPos)),
    member((_, _, _, _, chesterfields, ChesterPos), Hs),
    member((_, _, fox, _, _, FoxPos), Hs),
    (succ(FoxPos, ChesterPos); succ(ChesterPos, FoxPos)),
    member((_, _, _, orange_juice, lucky_strike, _), Hs),
    member((_, japanese, _, _, parliaments, _), Hs),
    member((_, _, _, milk, _, 2), Hs),
    member((_, norwegian, _, _, _, 0), Hs),
    member((blue, _, _, _, _, 1), Hs),
    member((_, _, zebra, _, _, _), Hs),
    member((_, _, _, water, _, _), Hs), !.

order([], 5).
order([Head | Tail], Idx) :-
    Head = (_, _, _, _, _, Idx),
    NewIdx is Idx + 1,
    order(Tail, NewIdx).

water_drinker(Drinker) :-
    houses(Hs),
    member((_, Drinker, _, water, _, _), Hs), !.

zebra_owner(Owner) :-
    houses(Hs),
    member((_, Owner, zebra, _, _, _), Hs), !.
