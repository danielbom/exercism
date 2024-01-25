:- use_module(library(clpfd)).
binary(Str, Dec) :-
	string_chars(Str, Digits),
	bin(Digits, 0, Dec).

bin([], A, A).
bin(['0'|T], A0, R) :- A #= 2 * A0, bin(T, A, R).
bin(['1'|T], A0, R) :- A #= 2 * A0 + 1, bin(T, A, R).
