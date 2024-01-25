beverage(Chef, Beverage) :-
	chefs(Cs),
	member(c(Chef, _, Beverage), Cs),
  !.

dish(Chef, Dish) :-
	chefs(Cs),
	member(c(Chef, Dish, _), Cs),
  !.

%c(Name, Dish, Beverage).
dish(pad_thai).
dish(frybread).
dish(tagine).
dish(biryani).

beverage(tonic).
beverage(lassi).
beverage(kombucha).
beverage(amasi).

chefs(Cs) :-
	length(Cs, 4),
	member(c(aisha, tagine, B1), Cs),
	member(c(emma, D3, amasi), Cs),
	member(c(_, frybread, tonic), Cs),
	member(c(mei, D1, lassi), Cs),
	member(c(winona, D2, _), Cs),
	beverage(B1),
	B1 \= amasi,
	B1 \= tonic,
	B1 \= lassi,
	dish(D3),
	dish(D1),
	dish(D2),
	D3 \= D1,
	D1 \= D2,
	D3 \= D2,
	D1 \= biryani,
	D1 \= tagine,
	D2 \= pad_thai,
	D3 \= tagine.
