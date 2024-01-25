parse_assert(Rule, Error) :-
  (call(Rule) -> true; throw(error(Error, _))).

parse_string(Stream, String, Rest) :-
  string_chars(String, Chars),
  append(Chars, Rest, Stream).

parse_digits([Digit | Stream], [Digit | Digits], Rest, Count) :-
  char_type(Digit, digit),
  NextCount is Count + 1,
  parse_digits(Stream, Digits, Rest, NextCount), !.
parse_digits(Stream, [], Stream, Count) :- Count > 0.
parse_digits(Stream, Digits, Rest) :-
  parse_digits(Stream, Digits, Rest, 0).

parse_integer(Stream, Digits, Rest) :-
  parse_digits(Stream, Digits, Rest).
parse_integer([Head | Stream], [Head | Digits], Rest) :-
  parse_string([Head], "-", []),
  parse_digits(Stream, Digits, Rest).

parse_operation(Stream, "+", Rest) :- parse_string(Stream, "plus", Rest), !.
parse_operation(Stream, "-", Rest) :- parse_string(Stream, "minus", Rest), !.
parse_operation(Stream, "*", Rest) :- parse_string(Stream, "multiplied by", Rest), !.
parse_operation(Stream, "/", Rest) :- parse_string(Stream, "divided by", Rest), !.

parse_end(Stream) :- parse_string(Stream, "?", []).

parse_rest(Stream, [], []) :-
  parse_end(Stream).
parse_rest(Stream0, [Op, Number | MathTokens], Rest) :-
  parse_assert(parse_string(Stream0, " ", Stream1), syntax_error),
  ( parse_integer(Stream1, _, _), throw(error(syntax_error, _))
  ; parse_assert(parse_operation(Stream1, Op, Stream2), unknown_operation_error)
  ),
  parse_assert(parse_string(Stream2, " ", Stream3), syntax_error),
  parse_assert(parse_integer(Stream3, Number, Stream4), syntax_error),
  parse_rest(Stream4, MathTokens, Rest).
parse_rest(Stream, [], Stream).

parse(Question, [FirstNumber | MathTokens]) :-
  string_chars(Question, Stream0),
  parse_assert(parse_string(Stream0, "What is", Stream1), unknown_operation_error),
  parse_assert(parse_string(Stream1, " ", Stream2), syntax_error),
  parse_assert(parse_integer(Stream2, FirstNumber, Stream3), syntax_error),
  parse_rest(Stream3, MathTokens, []),
  !.

integer_cast(NumberChars, Result) :-
  string_chars(Number, NumberChars),
  atom_number(Number, Result).

apply_op(Lhs, "+", Rhs, Result) :- Result is Lhs + Rhs.
apply_op(Lhs, "-", Rhs, Result) :- Result is Lhs - Rhs.
apply_op(Lhs, "*", Rhs, Result) :- Result is Lhs * Rhs.
apply_op(Lhs, "/", Rhs, Result) :- Result is Lhs / Rhs.

resolve([], Acc, Acc).
resolve([Op,Rhs|Rest], Acc, Result) :-
  integer_cast(Rhs, RhsValue),
  apply_op(Acc, Op, RhsValue, NextAcc),
  resolve(Rest, NextAcc, Result), !.

resolve([Fst|Rest], Result) :- 
  integer_cast(Fst, FstValue),
  resolve(Rest, FstValue, Result).

wordy(Question, Answer) :- 
  parse(Question, Tokens),
  resolve(Tokens, Answer).
