sum_of_multiples(Factors, Limit, Sum) :-
	L is Limit - 1,
	% get numbers from the interval
	findall(X, between(1, L, X), Numbers),
	% Select only those that are divisible by Factors
	include([N]>>once((member(F, Factors), N mod F =:= 0)), Numbers, Divisible),
	% Finally return the sum
	sum_list(Divisible, Sum).