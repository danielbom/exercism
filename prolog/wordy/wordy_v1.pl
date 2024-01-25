:- use_module(library(dcg/basics)).

operator("+") --> "plus", !.
operator("-") --> "minus", !.
operator("*") --> "multiplied by", !.
operator("/") --> "divided by", !.
operator(Num) --> number(Num), {throw(error(syntax_error, _))}.
operator(_)   --> {throw(error(unknown_operation_error, _))}.

parse_operator_with_number((Op, Value)) --> " ", operator(Op), " ", number(Value).
parse_operator_with_number((Op, _))     --> " ", operator(Op), {throw(error(syntax_error, _))}.

parse_rest([]) --> [].
parse_rest([OpValue | Tokens]) --> parse_operator_with_number(OpValue), parse_rest(Tokens).

parse_question --> "What is".
parse_question --> {throw(error(unknown_operation_error, _))}.

parse_first_number(Value) --> " ", number(Value).
parse_first_number(_)     --> {throw(error(syntax_error, _))}.

parse(FirstValue, Tokens) --> parse_question, parse_first_number(FirstValue), parse_rest(Tokens), "?", !.

wordy_compute(("+", Rhs), Lhs, Result) :- Result is Lhs + Rhs.
wordy_compute(("-", Rhs), Lhs, Result) :- Result is Lhs - Rhs.
wordy_compute(("*", Rhs), Lhs, Result) :- Result is Lhs * Rhs.
wordy_compute(("/", Rhs), Lhs, Result) :- Result is Lhs / Rhs.

wordy(Question, Answer) :- 
  string_codes(Question, Codes),
  phrase(parse(FirstValue, Operations), Codes, []),
  foldl(wordy_compute, Operations, FirstValue, Answer).
