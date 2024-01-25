:- use_module(library(dcg/basics)).
wordy(Question, Answer) :-
    string_codes(Question, Input),
    phrase(expr(Answer), Input).

expr(N) --> "What is", operand(L), operation(L, N), "?", !.
expr(_) --> { throw(error(unknown_operation_error, not_implemented)) }.

operation(L, L) --> [].
operation(L, V) --> " ", addition(L, O), operation(O, V).
operation(L, V) --> " ", subtraction(L, O), operation(O, V).
operation(L, V) --> " ", multiplication(L, O), operation(O, V).
operation(L, V) --> " ", division(L, O), operation(O, V).
operation(_, V) --> " ", integer(V), { throw(error(syntax_error, expected_operation)) }.
operation(_, _) --> { throw(error(unknown_operation_error, not_implemented)) }.

addition(L, V) --> "plus", operand(R), { V is L + R }.

subtraction(L, V) --> "minus", operand(R), { V is L - R }.

multiplication(L, V) --> "multiplied by", operand(R), { V is L * R }.

division(L, V) --> "divided by", operand(R), { V is L / R }.

operand(V) --> " ", integer(V).
operand(_) --> { throw(error(syntax_error, missing_operand)) }.
