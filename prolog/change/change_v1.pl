:- use_module(library(clpfd)).

fewest_coins(Coins, Target, Change) :-
    coins_change(Coins, Target, ChangeAggr, CoinsCount, CoinsTotal),
    once(labeling([min(CoinsTotal)], CoinsCount)),
    construct_coins(ChangeAggr, Change).

construct_coins([], []) :- !.
construct_coins([(_, 0) | Tail], Coins) :-
    !, construct_coins(Tail, Coins).
construct_coins([(Coin, Times) | Tail], [Coin | Coins]) :-
    NextTimes is Times - 1,
    construct_coins([(Coin, NextTimes) | Tail], Coins).

coins_change(UnsortedCoins, Target, Change, CoinsCount, CoinsTotal) :-
    sort(0, @=<, UnsortedCoins, Coins),
    length(Coins, N),
    length(CoinsCount, N),

    maplist(coin_count_bound(Target), Coins, CoinsCount),
    CoinsTotal #>= 0,
    CoinsTotal #=< Target,

    maplist(coin_relation, Coins, CoinsCount, Change),
    
    sum(CoinsCount, #=, CoinsTotal),
    coin_product(Coins, CoinsCount, CoinProducts),
    sum(CoinProducts, #=, Target).

coin_count_bound(Target, Coin, Count) :-
    Times is Target // Coin,
    Count in 0..Times.

coin_relation(Coin, Count, (Coin, Count)).

coin_product([], [], []).
coin_product([Coin|Coins], [Count|Counts], [Product|Products]) :-
    Product #= Coin * Count,
    coin_product(Coins, Counts, Products).
