roman_values([1000:"M",900:"CM",500:"D",400:"CD",100:"C",90:"XC",
              50:"L",40:"XL",10:"X",9:"IX",5:"V",4:"IV",1:"I"]).

convert(0, "").
convert(Num, Numeral) :-
    roman_values(RomanDict),
    member(Val:Str, RomanDict),
    Num >= Val,
    NewNum is Num - Val,
    convert(NewNum, Partial),
    string_concat(Str, Partial, Numeral),!.
