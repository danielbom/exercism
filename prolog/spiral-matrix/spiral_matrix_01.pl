% Well this is a bit of a mess for a first pass, but it works.
% The basic idea is to count up until you hit a corner and use
% a mask to "turn" the counter. This generates a list of 
% coordinates that follow a spiral pattern matched with
% a normal increasing counter. Sorting this list by the 
% coordinates puts the numbers in the correct order for the 
% spiral list of lists.

%   * * * * * * 0   [(1, 1)-1, (2, 1)-2 ... (7, 3)-9, (7, 4)-10 ...]
%   0 * * * * 0 *
%   * 0 * * 0 * *
%   * * 0 0 * * *
%   * * 0 * 0 * * 
%   * 0 * * * 0 *
%   0 * * * * * 0

spiral(0, []) :- !.
spiral(1, [[1]]) :- !.
spiral(N, Spiral) :-
    masks(N, Masks),
    scanl(maskadd, Masks, (1, 1), Coords),
    Len is N^2,
    numlist(1, Len, Range),
    pairs_keys_values(Pairs, Coords, Range),
    predsort(sortcoords, Pairs, PairsSorted),
    pairs_values(PairsSorted, Numbers),
    split_list_into_lens(N, Numbers, Spiral).

sortcoords(Order, (A, B)-_, (C, D)-_) :-
    compare(Order, (B, A), (D, C)).

split_list_into_lens(Len, Lst, Lsts) :-
    must_be(positive_integer, Len),
    split_list_into_lens_(Lst, Len, Lsts).
split_list_into_lens_([], _, []).
split_list_into_lens_([H|T], Len, [LstSplit|Lsts]) :-
    (   length(LstSplit, Len),
        append(LstSplit, LstRemainder, [H|T]) -> true
    ;   LstSplit = [H|T], 
        length(LstSplit, LenSplitFinal),
        LenSplitFinal < Len,
        LstRemainder = [] ),
    split_list_into_lens_(LstRemainder, Len, Lsts).

nextmask(Current, Next) :-
    Masks = [(1, 0), (0, 1), (-1, 0), (0, -1), (1, 0)],
    nextto(Current, Next, Masks), !.

masks(N, Masks) :-
    maskcounts(N, Counts),
    maskmap(Counts, Masks).

maskcounts(N, [N1 | Masks]) :-
    N1 is N - 1,
    numlist(1, N1, Range),
    maplist(doubler, Range, Masks1),
    reverse(Masks1, Masks2),
    flatten(Masks2, Masks).

doubler(N, [N, N]).

maskmap(ListIn, ListOut) :-
    maskmap((1, 0), ListIn, ListOut1),
    flatten(ListOut1, ListOut).
maskmap(_, [], []) :- !.
maskmap(Mask, [N | ListIn1], [Masks | ListOut1]) :-
    dup(N, Mask, Masks),
    nextmask(Mask, NextMask), !,
    maskmap(NextMask, ListIn1, ListOut1).

dup(N, I, List) :- findall(I, between(1, N, _), List).

maskadd((A, B), (C, D), (X, Y)) :- X is A + C, Y is B + D.

%   * * * * * * 0   * * * * * 0    * * * * 1     * * * 1     * * *
%   0 * * * * 0 *   0 * * * 0 *    4 * * 5 *     4 * 5 *     * * *
%   * 0 * * 0 * *   * 0 * 0 * *    * 8 9 * *     * 7 6 *     * * *
%   * * 0 0 * * *   * * 0 0 * *    * 7 * 6 *     3 * * 2     
%   * * 0 * 0 * *   * 0 * * 0 *    3 * * * 2
%   * 0 * * * 0 *   0 * * * * 0
%   0 * * * * * 0   

% 1 2 3
% 8 9 4
% 7 6 5

% 1  2  3  4
% 12 13 14 5
% 11 16 15 6
% 10  9  8 7

% numlist is eager, between is lazy
% numlist(1, N**2, Range) or between(0, N**2, Range)
