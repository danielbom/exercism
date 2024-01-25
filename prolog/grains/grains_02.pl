% -----------------------------------------------------------------------------
% exercism.org
% Prolog Track Exercise: grains
% Contributed: Anthony J. Borla (ajborla@bigpond.com)
%
% Platform:   SWI-Prolog (https://www.swi-prolog.org/)
% Testing:    swipl -f grains.pl -s grains_tests.plt
%                   -g run_tests,halt -t 'halt(1)'
% -----------------------------------------------------------------------------

% -----------------------------------------------------------------------------
% square(+Square, ?Grains)
% ----
% Given Square, a chessboard square number from the range 1 to 64 inclusive,
% unifies Grains with the total number of grains on the specified square, based
% on the notion that each square contains 2 ** (Square - 1) grains
% -----------------------------------------------------------------------------
square(Square, Grains) :-
    number(Square), Square > 0, Square < 65,
    Power is Square - 1, Grains is 2 ** Power.

% -----------------------------------------------------------------------------
% total(-Total)
% ----
% Unifies Total with the total number of grains on a chessboard (see square/2)
% -----------------------------------------------------------------------------
total(Total) :-
    numlist(1, 64, NumList), total(NumList, 0, Total).
total([], Accum, Accum) :- !.
total([H|Tail], Accum, Total) :-
    square(H, Grains), NewAccum is Accum + Grains,
    total(Tail, NewAccum, Total).

% -----------------------------------------------------------------------------
% Module version in MAJOR.MINOR.PATCH format
% -----------------------------------------------------------------------------
version('1.1.0').
