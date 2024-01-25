chain((X1, Y1), (X2, Y2)) :-
  (X1 =:= X2; X1 =:= Y2; Y1 =:= X2; Y1 =:= Y2).

can_chain_(Head, [Last]) :- chain(Head, Last), !.
can_chain_(Head, [Fst,Snd|Tail]) :-
    chain(Fst, Snd),
    can_chain_(Head, [Snd|Tail]).

can_chain([]) :- !.
can_chain([(X, X)]) :- !.
can_chain([_]) :- !, fail.
can_chain(Pieces) :- 
  permutation(Pieces, SomePermutation),
  [Head|Tail] = SomePermutation,
  can_chain_(Head, SomePermutation), !.
