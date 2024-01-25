flatten_list([], []).
flatten_list([nil | Rest], XsFlattened) :-
  flatten_list(Rest, XsFlattened),
  !.
flatten_list([X | Rest], XsFlattened) :-
  is_list(X),
  flatten_list(X, SubXsFlattened),
  flatten_list(Rest, NextXsFlattened),
  append(SubXsFlattened, NextXsFlattened, XsFlattened),
  !.
flatten_list([X | Rest], [X | XsFlattened]) :-
  flatten_list(Rest, XsFlattened).
