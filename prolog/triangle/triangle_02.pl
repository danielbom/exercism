triangle(A, B, C, Type) :-
  maplist(positive, [A,B,C]),
  inequality(A, B, C),
  tri_type(A,B,C,Type).

inequality(A,B,C) :-
  A + B > C,
  B + C > A,
  C + A > B.

tri_type(A,A,A, "equilateral") :- !.
tri_type(A,B,C, "isosceles") :-
  \+ tri_type(A,B,C, "scalene"), !.
tri_type(A,B,C, "scalene") :-
  sort([A,B,C], [_,_,_]), !.

positive(N) :-
  N > 0.
