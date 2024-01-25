:- use_module(library(clpfd)).

sum_of_multiples(Factors, Limit, Sum) :-
  L #= Limit - 1,
  findall(Multiple, 
	  (numlist_multiple(Factors, Multiple), Multiple in 0..L, indomain(Multiple)),
	  Multiples),
  sort(Multiples, Ms),
  sum(Ms, #=, Sum).

num_multiple(N, M) :- M mod N #= 0.

numlist_multiple([], _) :- false.
numlist_multiple([N|Ns], M) :-
  M mod N #= 0;
  numlist_multiple(Ns, M).