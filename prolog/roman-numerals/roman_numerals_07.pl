convert(N, Numeral) :-
    foldl(
        add_digits,
        ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"],
        [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1],
        N-"",
        0-Numeral
    ).

add_digits(Digit, Value, N-Acc, N0-Numeral) :-
    % roman numeral  Numeral  represents  N
    % roman numeral  Acc      represents  N0
    % it is assumed that  N0 <= N
    divmod(N, Value, Multiplicity, N0),
    replicate(Multiplicity, Digit, ReplicatedDigit),
    foldl(flip(string_concat), ReplicatedDigit, Acc, Numeral).

replicate(N, X, List) :-
    length(List, N),
    maplist(=(X), List).
    
flip(F, X, Y, Z) :- call(F, Y, X, Z).
