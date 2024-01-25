wordy(Question, Answer) :-
    split_string(Question, "\s?", "\s?", Words),
    wordy(Words, 0, Answer).

wordy([], Accum, Accum).
wordy(["What","is"], _, _) :-
    throw(error(syntax_error,"")).
wordy(["What","is"|Rest], Accum, Answer) :-
    wordy(Rest, Accum, Answer), !.
wordy(["Who","is"|_], _, _) :-
    throw(error(unknown_operation_error, UnknownOperator)).
wordy([X], _, _) :-
    member(X, ["plus", "minus"]),
    throw(error(syntax_error, Answer)).
wordy(["plus", X|Rest], Accum, Answer) :-
    atom_number(X, Token),
    NewAccum is Accum + Token,
    wordy(Rest, NewAccum, Answer), !.
wordy(["minus", X|Rest], Accum, Answer) :-
    atom_number(X, Token),
    NewAccum is Accum - Token,
    wordy(Rest, NewAccum, Answer), !.
wordy(["multiplied", "by", X|Rest], Accum, Answer) :-
    atom_number(X, Token),
    NewAccum is Accum * Token,
    wordy(Rest, NewAccum, Answer), !.
wordy(["divided", "by", X|Rest], Accum, Answer) :-
    atom_number(X, Token),
    NewAccum is Accum / Token,
    wordy(Rest, NewAccum, Answer), !.
wordy([First|Rest], 0, Answer) :-
    atom_number(First, Token),
    wordy(Rest, Token, Answer), !.
wordy([First|Rest], _, Answer) :-
    atom_number(First, Token),
    throw(error(syntax_error, Token)).
wordy([UnknownOperator, X|Rest], _, _) :-
    atom_number(X, _),
    throw(error(unknown_operation_error, UnknownOperator)).
wordy([UnknownOperator], _, _) :-
    throw(error(unknown_operation_error, UnknownOperator)).
wordy(_, Answer, _) :-
    throw(error(syntax_error, Answer)).