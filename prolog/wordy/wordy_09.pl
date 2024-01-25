digits([D|T]) -->  digit(D), !, digits(T).
digits([]) --> [].

digit(D) --> [D], { code_type(D, digit) }.

num(N) -->
        digit(D0),
        digits(D),
        { number_codes(N, [D0|D]) }.

neg(N) --> "-", num(M), { N is -M }.

int(N) --> neg(N), ! ; num(N).

% this rule is tabled to allow for left-recursion
% cuts are required to ensure the longest match is parsed first
:- table expr/3.

expr(C) --> expr(A), " plus ", int(B), { C is A + B }, !.
expr(C) --> expr(A), " minus ", int(B), { C is A - B }, !.
expr(C) --> expr(A), " multiplied by ", int(B), { C is A * B }, !.
expr(C) --> expr(A), " divided by ", int(B), { C is A / B }, !.
expr(A) --> int(A), !.
% unary postfix operations are unimplemented
expr(_) --> 
    int(_), " ", 
    { throw(error(unknown_operation_error, "unimplemented")) }.

question(Ans) --> "What is ", expr(Ans), "?".
question(_) --> 
    "What is", { throw(error(syntax_error, "malformed expression")) }.
question(_) --> 
    "Wh", { throw(error(unknown_operation_error, "invalid question")) }.

wordy(Question, Answer) :- 
    string_codes(Question, Codes),
    once(phrase(question(Answer), Codes, _)).
