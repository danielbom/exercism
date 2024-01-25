sum_of_multiples(Factors, Limit, Sum) :-
  N is Limit - 1,
  go(Factors, N, Sum).

go(_, 0, 0) :- !.
go(Factors, N, Sum) :-
  N > 0,
  DecN is N - 1,
  (  any(multiple(N), Factors)
  -> go(Factors, DecN, SumRest),
     Sum is N + SumRest
  ;  go(Factors, DecN, Sum)
  ).

any(P, [X|Xs]) :-
  call(P, X);
  any(P, Xs).

multiple(A, B) :-
  0 =:= mod(A, B).
