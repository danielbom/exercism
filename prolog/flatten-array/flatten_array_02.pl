% Take a nested list and return a single flattened list with all values except nil/null.
flatten_list(nil,[]) :- !.
flatten_list(null,[]) :- !.
flatten_list([], []) :- !.
flatten_list([L|R], F) :-
  !,
  flatten_list(L, FL),
  flatten_list(R, FR),
  append(FL, FR, F).
flatten_list(L, [L]).
