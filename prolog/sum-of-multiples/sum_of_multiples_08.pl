:- use_module(library(clpfd)).

sum_of_multiples([],_,0).
sum_of_multiples(Factors, Limit, Sum) :-
	findall(X, factors_limit_list(Factors, Limit, X), Bag),
	sort(Bag, Set),
	sum_list(Set, Sum).

factors_limit_list(Factors, Limit, Factor) :-
	factors_limit_list_helper(Factors, Limit, Factor),
	label([Factor]).

factors_limit_list_helper(Factors, Limit, Factor) :-
	member(X, Factors),
	Y #> 0,
	X * Y #= Factor,
	Factor #< Limit. 
