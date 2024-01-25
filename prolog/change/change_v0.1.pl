fewest_coins(Coins, Target, Change) :-
  	findall(PossibleChange, possible_changes(Coins, Target, PossibleChange), PossibleChanges),
    aggregate_all(min(N, X), (member(X, PossibleChanges), count_coins(X, N)), min(_, ReversedChange)),
    construct_coins(ReversedChange, ReversedChangeComplete),
    reverse(ReversedChangeComplete, Change),
    !.

possible_changes(Coins, Target, Change) :-
    sort(0, @>=, Coins, ReversedSortedCoins),
    possible_changes_go(ReversedSortedCoins, Target, Change).

possible_changes_go(Coin, Target, Change) :-
    MinimumCoinsCount is Target + 1,
    possible_changes_go0(Coin, Target, Change, MinimumCoinsCount).

possible_changes_go0(Coin, Target, Change, MinimumCoinsCount) :-
    possible_changes_go1(Coin, Target, FirstChange, 0, MinimumCoinsCount),
    count_coins(FirstChange, CoinsCount),
    (	CoinsCount =\= 0, possible_changes_go0(Coin, Target, Change, CoinsCount)
    ;	Change = FirstChange
    ).

possible_changes_go1(_, 0, [], _, _) :- !.
possible_changes_go1(Coins, Target, [(Coin, Times) | NextChange], CoinsCount, MinimumCoinsCount) :-
    member(Coin, Coins),
    Coin =< Target,
    TotalTimes is Target // Coin,
    between(0, TotalTimes, TimeDiscount),
    Times is TotalTimes - TimeDiscount,
    NextTarget is Target - Times * Coin,
    NextCoinsCount is CoinsCount + Times,
    (NextCoinsCount >= MinimumCoinsCount, !, fail; true),
    findall(X, (member(X, Coins), X =< NextTarget, X < Coin), NextCoins),
    possible_changes_go1(NextCoins, NextTarget, NextChange, NextCoinsCount, MinimumCoinsCount), !.

count_coins([], Acc, Acc).
count_coins([(_, Times) | Tail], Acc, Result) :-
    NextAcc is Acc + Times,
    count_coins(Tail, NextAcc, Result).
count_coins(Coins, Result) :- count_coins(Coins, 0, Result).

construct_coins([], []) :- !.
construct_coins([(_, 0) | Tail], Coins) :-
    !, construct_coins(Tail, Coins).
construct_coins([(Coin, Times) | Tail], [Coin | Coins]) :-
    NextTimes is Times - 1,
    construct_coins([(Coin, NextTimes) | Tail], Coins).
