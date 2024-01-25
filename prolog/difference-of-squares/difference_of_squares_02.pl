square_of_sum(N, Result) :-
    Result is N ^ 2 * (N + 1) ^ 2 // 4.

sum_of_squares(N, Result) :-
    Result is N * (N + 1) * (2 * N + 1) // 6.

difference(N, Result) :-
    Result is N * (N - 1) * (N + 1) * (3 * N + 2) // 12.
