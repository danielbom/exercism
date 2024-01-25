% https://exercism.org/tracks/prolog/exercises/change/solutions/jvlmdr
% https://exercism.org/profiles/jvlmdr

:- table fewest_coins/3.

fewest_coins(_, 0, []).
fewest_coins(Coins, Target, Change) :-
    Target > 0,
    convlist(solve_subproblem(Coins, Target), Coins, Solutions),
    min_member(length_leq, Change, Solutions).

length_leq(A, B) :- length(A, LenA), length(B, LenB), LenA =< LenB.

solve_subproblem(Coins, Target, Coin, Change) :-
    plus(SubTarget, Coin, Target),
    fewest_coins(Coins, SubTarget, SubChange),
    Change = [Coin | SubChange].
