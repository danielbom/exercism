is_triangle(Side1, Side2, Side3) :-
  Side1 > 0, Side2 > 0, Side3 > 0,
  Side1 + Side2 >= Side3,
  Side1 + Side3 >= Side2,
  Side2 + Side3 >= Side1.


triangle(Side1, Side2, Side3, Type) :-
  is_triangle(Side1, Side2, Side3),
  ( Side1 \= Side2, Side2 \= Side3, Side1 \= Side3, !, Type = "scalene"
  ; Side1 = Side2, Side2 = Side3, Type = "equilateral", !
  ; Type = "isosceles"
  ).
