fewest_coins(_, 0, Change) :- Change = [], !. % handle unusual test case
fewest_coins(Coins, Target, Change) :-
  % Finding the minimum length Change took me much longer than finding the Change's.
%   candidate(Coins, Target, Change),
%     \+ (candidate(Coins, Target, ChangeAlt),
%         length(ChangeAlt, LAlt), length(Change, L), LAlt < L).
  % Apparently the above can be terribly inefficient, putting me on a perplexing journey.
  % The alternative below is derived from:
  % https://stackoverflow.com/questions/67523010/getting-the-shortest-list-from-a-list-of-lists
%   aggregate(min(L,MinChange), % find min L, and produce a term "min(min L, Change with that min L)"
%             (candidate(RCoins, Target, MinChange), % produce MinChange's,
%              length(MinChange, L)),               % and their lengths
%             min(_,Change)). % extract 2nd element from "min(min L, Change with that min L)"
  % But that's still not good enough because *all* solutions, even those much longer than we care
  % about, still get fully explored, easily leading to stack overflow. Instead, we need to prune
  % crappy solutions as soon as we can.
  sort(Coins, SCoins),
  [SmallestCoin|_] = SCoins, % First, rule out the case where we don't have a coin small enough
  SmallestCoin =< Target,    % to reach the target.
  reverse(SCoins, RCoins),   % Second, select coins from biggest to smallest so we can skip past
                             % all the crappy solutions with lots of small denominations.
  % Then, because I can't find a way to update MaxDepth while backtracking, incrementally
  % increase the depth we search and restart the search, until we find a single solution.
  MaxCoins is Target div SmallestCoin, % It's possible there's no solution,
  between(1,MaxCoins,MaxDepth),        % so don't go beyond the worse case.
  %length(_,MaxDepth), % length doubles as a counter-maker: https://stackoverflow.com/questions/67523010/getting-the-shortest-list-from-a-list-of-lists/67523976#comment134502900_67523976
  candidate(RCoins, Target, RChange, 0, MaxDepth), !, % Finally, the 1st candidate found is success.
  msort(RChange, Change). % Put it back in ascending order before returning

% Okay, now the easy bit! Find Change combos from Coins that meet Target.
% First check if there's a coin that will get us there.
candidate(Coins, Target, Change, _, _) :-
  nth0(_, Coins, Target),
  Change = [Target].

% Otherwise pick one that is less than target.
candidate(Coins, Target, Change, Depth, MaxDepth) :-
  Depth < MaxDepth, % Give up if we've already gone deep enough.
  nth0(0, Coins, BiggestCoin), % Coins is expected to be reverse sorted.
  BiggestCoin * (MaxDepth-Depth) >= Target, % Also give up if we can never get there.
  select(Coin, Coins, _), % select with replacement
  RTarget is Target - Coin,
  RTarget > 0,
  NDepth is Depth+1,
  candidate(Coins, RTarget, RChange, NDepth, MaxDepth),
  Change = [Coin | RChange].
