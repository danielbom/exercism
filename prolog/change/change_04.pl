% attempt at finding smallest solutions only, a bit faster, sadly returns a lot of repeating solutions
% assumes that starting with largest values first might be a better heuristic
% stops looking into a possible solution if the amount of steps was passed over
fewest_coins(Coins, Target, MinChange):-
    reverse(Coins, RevCoins),
    fewest_coins(RevCoins, Target, RevMinChange, inf),
    reverse(RevMinChange, MinChange).
fewest_coins(Coins, Target, MinChange, Count):-
    fewest_coins_(Coins, Target, Change, 0, Count, NewCount),
    NewCount < Count,
    (\+ fewest_coins(Coins, Target, _, NewCount) -> 
    	MinChange = Change ; 
    	fewest_coins(Coins, Target, MinChange, NewCount)
    ).

% actual implementation, finds all possible solutions with constraint on known length
fewest_coins_(_, 0, [], Count, _, Count).
fewest_coins_([Coin | Coins], Target, [Coin | Change], Count, MaxCount, FinalCount):-
    Target > 0,
    Coin =< Target,
    NextTarget is Target - Coin,
    succ(Count, NextCount),
    NextCount < MaxCount,
    fewest_coins_([Coin | Coins], NextTarget, Change, NextCount, MaxCount, FinalCount).
fewest_coins_([_ | Coins], Target, Change, Count, MaxCount, FinalCount):-
    Target > 0,
    Count < MaxCount,
    fewest_coins_(Coins, Target, Change, Count, MaxCount, FinalCount).

% exhaustive search, finds minimum solutions, too slow for large solution sets
fewest_coins_exhaustive(Coins, Target, MinChange):-
    setof(Change, fewest_coins_original(Coins, Target, Change), SetOfPossibleChanges),
    maplist(length, SetOfPossibleChanges, Lengths),
    min_list(Lengths, Minimum),
    pairs_keys_values(Pairs, SetOfPossibleChanges, Lengths),
    include([_-Val]>>(Val =:= Minimum), Pairs, MinPairs),
    member(MinChange-_, MinPairs).

% actual implementation, finds all possible solutions. Enough to solve this exercise
% despite not needing to find minimal solution only
fewest_coins_original(_, 0, []).
fewest_coins_original([Coin | Coins], Target, [Coin | Change]):-
    Target > 0,
    Coin =< Target,
    NextTarget is Target - Coin,
    fewest_coins_original([Coin | Coins], NextTarget, Change).
fewest_coins_original([_ | Coins], Target, Change):-
    Target > 0,
    fewest_coins_original(Coins, Target, Change).