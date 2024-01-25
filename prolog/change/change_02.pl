fewest_coins(Coins, Target, Change) :-
    reverse(Coins, Coins2), coins(Coins2, Target, Change).

coins(_, 0, []).
coins([Coin | Coins], Target, Change) :-
    Target >= Coin, NewTarget is Target - Coin,
    coins([Coin | Coins], NewTarget, NewChange),
    append(NewChange, [Coin], Change).
coins([_Coin | Coins], Target, Change) :-
    coins(Coins, Target, Change).