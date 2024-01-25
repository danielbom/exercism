child(alice).
child(bob).
child(charlie).
child(david).
child(eve).
child(fred).
child(ginny).
child(harriet).
child(ileana).
child(joseph).
child(kincaid).
child(larry).

plant('G', grass).
plant('C', clover).
plant('R', radishes).
plant('V', violets).

find_child_plants(Child, [P1, P2 | _], [P3, P4 | _], [Child | _], [P1, P2, P3, P4]) :- !.
find_child_plants(Child, [_, _ | Line1], [_, _ | Line2], [_ | Children], Plants) :-
  find_child_plants(Child, Line1, Line2, Children, Plants).

garden(Garden, Child, Plants) :-
  split_string(Garden, "\n", "", [String1, String2]),
  string_chars(String1, Line1), string_chars(String2, Line2),
  findall(X, child(X), Children),
  find_child_plants(Child, Line1, Line2, Children, PlantsChars),
  maplist(plant, PlantsChars, Plants).
