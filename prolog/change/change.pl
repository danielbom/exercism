:- use_module(library(clpfd)).

fewest_coins(CoinsUnsorted, Target, Change) :-
    sort(0, @>, CoinsUnsorted, Coins),
    maplist(coin_count_bound(Target), Coins, CoinsCount),
    sum(CoinsCount, #=, CoinsTotal),
    scalar_product(Coins, CoinsCount, #=, Target),
    labeling([min(CoinsTotal)], CoinsCount),
    maplist(coin_relation, Coins, CoinsCount, ChangeAggr),
    construct_coins(ChangeAggr, ChangeReversed),
    sort(0, @=<, ChangeReversed, Change),
    !.

construct_coins([], []).
construct_coins([(_, 0) | Tail], Coins) :- 
    construct_coins(Tail, Coins).
construct_coins([(Coin, Times) | Tail], [Coin | Coins]) :-
    Times > 0,
    NextTimes is Times - 1,
    construct_coins([(Coin, NextTimes) | Tail], Coins).

coin_count_bound(Target, Coin, Count) :-
    Times #= Target // Coin,
    Count in 0..Times.

coin_relation(Coin, Count, (Coin, Count)).
