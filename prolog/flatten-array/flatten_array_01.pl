flatten_list(Xs, XsFlattened) :-
  flatten(Xs, Flattened),
  exclude(=(nil), Flattened, XsFlattened).