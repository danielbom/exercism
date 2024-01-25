:- use_module(library(clpfd)).

convert(N, Numeral) :-
    phrase(arabic_to_roman(N), Codes), !,
    string_codes(Numeral, Codes).

arabic_to_roman(0) --> "".
arabic_to_roman(N) -->
    { Rest #>= 0 },
    { N #= Value + Rest },
    roman(Value),
    arabic_to_roman(Rest).

roman(1000) --> "M".
roman(900) --> "CM".
roman(500) --> "D".
roman(400) --> "CD".
roman(100) --> "C".
roman(90) --> "XC".
roman(50) --> "L".
roman(40) --> "XL".
roman(10) --> "X".
roman(9) --> "IX".
roman(5) --> "V".
roman(4) --> "IV".
roman(1) --> "I".
