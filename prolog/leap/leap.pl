leap(Year) :-
  Remainder4   is Year mod 4,
  Remainder100 is Year mod 100,
  Remainder400 is Year mod 400,
  Remainder4 =:= 0,
  once(Remainder400 =:= 0; Remainder100 =\= 0).
