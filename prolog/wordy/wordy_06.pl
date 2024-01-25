% wordy/2 answers a math question if Question is valid.
% Question is valid if it is:
% a string in given format 'What is <Number> (<Operator> <Number>)* ?'
% allows arbitrary amount of spaces in between tokens
% expects that strings are handled as strings, not as lists
% throws exceptions if question can't be parsed
wordy(Question, Answer) :- 
    string_lower(Question, QuestionInLowerCase),
    string_chars(QuestionInLowerCase, Chars),
    phrase(parse_math_start(Answer), Chars), !.

% arbitrary spaces allowed
spaces --> space.
spaces --> space, spaces.
space --> [' '].

% for human readability
what_is --> ['w','h','a','t'], spaces, [ 'i', 's'].

end_of_question --> spaces, ['?'].
end_of_question --> ['?'].

% Check if form of question is following the correct start form
parse_math_start(Answer) --> what_is, parse_number(Num), parse_math(Num, Answer).

% throw errors if not 
parse_math_start(_) --> what_is, parse_operator(_), {throw(error(syntax_error, _))}.
parse_math_start(_) --> what_is, end_of_question, {throw(error(syntax_error, _))}.
parse_math_start(_) --> {throw(error(unknown_operation_error, _))}.

% parse the rest of the question
parse_math(Answer, Answer) --> end_of_question.
parse_math(Acc, Answer) --> parse_operator(Op),
							parse_number(Num),
								{
									atomic_list_concat([Acc, ' ', Op, ' ', Num], Eval),
									term_to_atom(EvalTerm, Eval),
									NewAcc is EvalTerm
								},
							parse_math(NewAcc, Answer).

% throw errors if not possible
parse_math(_, _) --> parse_operator(_), end_of_question, {throw(error(syntax_error, _))}.
parse_math(_, _) --> parse_operator(_), parse_operator(_), {throw(error(syntax_error, _))}.
parse_math(_, _) --> parse_number(_), {throw(error(syntax_error, _))}.
parse_math(_, _) --> {throw(error(unknown_operation_error, _))}.

% parse number and operator allow arbitrary amount of whitespaces before parsing
parse_number(Num) --> spaces, number(Num).
parse_number(Num) --> number(Num).

parse_operator(Op) --> spaces, parse_operator(Op).
parse_operator('+') --> ['p', 'l', 'u', 's'].
parse_operator('-') --> ['m', 'i', 'n', 'u', 's'].
parse_operator('*') --> ['m','u','l','t','i','p','l','i','e','d', ' ', 'b', 'y'].
parse_operator('/') --> ['d','i','v','i','d','e','d',' ','b','y'].

% own number parser, instead of importing some library
number(Number) --> number_(NumberChars), {number_chars(Number, NumberChars)}.

number_(['-'|Ds]) --> ['-'], number_(Ds).
number_([D|Ds]) --> digit(D), number_(Ds).
number_([D]) --> digit(D).

digit(D) --> [D], {catch(is_a_digit(D), _, false)}.

is_a_digit(D):-
	number_chars(E, [D]), between(0, 9, E).
