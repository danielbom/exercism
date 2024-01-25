uniq([], []).
uniq([H | T], R)        :- member(H, T), uniq(T, R).
uniq([H | T], [H | T1]) :- \+ member(H, T), uniq(T, T1).

valid(A, B, C) :- sort(0, @=<, [A, B, C], [X, Y, Z]), X + Y > Z.

sides(A, B, C, R) :- valid(A, B, C), uniq([A, B, C], U), length(U, R).

triangle(A, B, C, "equilateral") :- sides(A, B, C, 1), !.
triangle(A, B, C, "isosceles")   :- sides(A, B, C, R), (R = 1 ; R = 2), !.
triangle(A, B, C, "scalene")     :- sides(A, B, C, 3), !.
