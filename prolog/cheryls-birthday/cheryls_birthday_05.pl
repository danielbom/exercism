candidates(Month, Day) :-
    member((Month,Day),
	   [
	       (may, 15), (may, 16), (may, 19),
	       (june, 17), (june, 18),
	       (july,14), (july,16),
	       (august,14), (august,15), (august,17)
	   ]
	  ).

month_has_unique_day(Month):-
    candidates(Month, Day),
    findall(M, candidates(M, Day), [_]).

clue1(Month, Day) :-
    candidates(Month, Day),
    findall(X, candidates(Month, X), [_, _|_]),
    \+ month_has_unique_day(Month).
    
clue2(Month, Day) :-
    candidates(Month, Day),
    findall(X, clue1(X, Day), [Month]).
    
clue3(Month, Day) :-
    candidates(Month, Day),
    findall(X, clue2(Month, X), [Day]).

cheryls_birthday(Month, Day) :- clue3(Month, Day), !.
