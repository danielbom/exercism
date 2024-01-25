pascal(0, []) :- !.
pascal(1, [[1]]) :- !.
pascal(N, Triangle) :-
    succ(M, N),
    pascal(M, Prev),
    last(Prev, PrevRow),
    add_zeros(PrevRow, PrevRowZeros),
    next_level(PrevRowZeros, Row),
    append(Prev, [Row], Triangle).

next_level([_], []) :- !.
next_level([A, B|R], [C|S]) :- plus(A, B, C), next_level([B|R], S).

add_zeros(In, Out) :- append([0], In, L), append(L, [0], Out).