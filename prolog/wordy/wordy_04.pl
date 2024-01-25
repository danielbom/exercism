wordy(Question, Answer) :-
    split_string(Question, " ", "?", [_, "is" | Words]),
    maplist(try_parse_num, Words, Parsed),
    calc(Parsed, Answer).

try_parse_num(X, Out):- atom_number(X, Out), !; X = Out.

calc([X], X):- !.
calc([L, "plus", R | T], Answer):- number(R), !,
    X is L + R,
    calc([X | T], Answer).
calc([L, "minus", R | T], Answer):- !,
    X is L - R,
    calc([X | T], Answer).
calc([L, "multiplied", "by", R | T], Answer):- !,
    X is L * R,
    calc([X | T], Answer).
calc([L, "divided", "by", R | T], Answer):- !,
    X is L / R,
    calc([X | T], Answer).
calc([_, "cubed"], _):- throw(error(unknown_operation_error, 0)).
calc([_, "President" | _], _):- throw(error(unknown_operation_error, 0)).
calc(_, _):- throw(error(syntax_error, 0)).
