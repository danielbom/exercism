square(SquareNumber, Value) :-
    between(1, 64, SquareNumber),
    Value is 2 ** (SquareNumber - 1).

total(Value) :-
    square(64, Last),
    Value is Last * 2 - 1.
