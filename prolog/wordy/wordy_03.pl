% This was a fun experiment with DCGs that got out of hand...
% Grammar
question(Expression) --> `What is`, expression(Expression), `?`, {!}.
question(_) --> {throw(error(unknown_operation_error, ill_formed_question))}.

expression(_) --> ` `, operand(_), ` `, operand(_),
                  {throw(error(syntax_error, operator_missing))}.
expression([Operand,Operation|Expression]) --> ` `,
                                               operand(Operand),
                                               ` `,
                                               operation(Operation),
                                               expression(Expression).
expression([Operand]) --> ` `, operand(Operand).
expression(_) --> ``, {throw(error(syntax_error, empty_expression))}.

operand(Integer) --> digit(Digit),
                     digits(Digits),
                     {foldl(positive, Digits, Digit, Integer)}.
operand(Integer) --> `-`,
                     digit(Digit),
                     digits(Digits),
                     {foldl(negative, Digits, -Digit, Integer)}.

digits([Digit|Digits]) --> digit(Digit), digits(Digits).
digits([]) --> [].

digit(0) --> `0`.
digit(1) --> `1`.
digit(2) --> `2`.
digit(3) --> `3`.
digit(4) --> `4`.
digit(5) --> `5`.
digit(6) --> `6`.
digit(7) --> `7`.
digit(8) --> `8`.
digit(9) --> `9`.

operation(*) --> `multiplied by`.
operation(+) --> `plus`.
operation(-) --> `minus`.
operation(/) --> `divided by`.
operation(Operation) --> {throw(error(unknown_operation_error, Operation))}.

% Logic
apply(Left, *, Right, Result) :- !, Result is Left * Right.
apply(Left, +, Right, Result) :- !, Result is Left + Right.
apply(Left, -, Right, Result) :- !, Result is Left - Right.
apply(Left, /, Right, Result) :- !, Result is Left / Right.

evaluate([], Result, Result).
evaluate([Operation,Operand|Expressions], Accumulator, Result) :-
    apply(Accumulator, Operation, Operand, NewAccumulator),
    evaluate(Expressions, NewAccumulator, Result).

negative(Element, Accumulator, Result) :- Result is 10*Accumulator - Element.

positive(Element, Accumulator, Result) :- Result is 10*Accumulator + Element.

wordy(Question, Answer) :- string_codes(Question, Codes),
                           question([Operand|Expressions], Codes, []),
                           evaluate(Expressions, Operand, Answer).
