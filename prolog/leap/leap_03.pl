leap(Year) :-
    Year mod 400 =:= 0 -> true;
    Year mod 100 =:= 0 -> false;
    Year mod 4 =:= 0.