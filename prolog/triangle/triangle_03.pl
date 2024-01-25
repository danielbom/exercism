categorize(X, Y, Z, R) :-
    ( X = Y, Y = Z          -> (R = "equilateral"; R = "isosceles")
    ; (X = Y; Y = Z; X = Z) -> R = "isosceles"
    ; R = "scalene"
    ).

triangle(X, Y, Z, R) :-
    X > 0,
    Y > 0,
    Z > 0,
    X + Y >= Z,
    X + Z >= Y,
    Y + Z >= X,
    categorize(X, Y, Z, R).
