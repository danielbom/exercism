convert(0, '') :- !.
convert(N, M) :-
    numeral(Value, Numeral),
    N >= Value, % If true: Prolog continues to the next line. Else: Prolog backtracks and tries the next fact in the numeral predicate.
    N1 is N - Value, % New number that we'll pass to the next recursive call of convert.
    convert(N1, M1), % A recursive call is trying to convert the number N1 (which is N - Value) into a Roman numeral M1.
    string_concat(Numeral, M1, M), !.

numeral(1000, 'M').
numeral(900, 'CM').
numeral(500, 'D').
numeral(400, 'CD').
numeral(100, 'C').
numeral(90, 'XC').
numeral(50, 'L').
numeral(40, 'XL').
numeral(10, 'X').
numeral(9, 'IX').
numeral(5, 'V').
numeral(4, 'IV').
numeral(1, 'I').