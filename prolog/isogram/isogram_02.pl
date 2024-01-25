% easier to work with list of chars
isogram(Candidate) :-
    % need to make all one case so that A and a are recognised as the same
    % http://www.swi-prolog.org/pldoc/man?predicate=string_lower/2
    string_lower(Candidate, Lowered),
    string_chars(Lowered, Chars),
    isogram_chars(Chars).

% a single char is obviously an isogram
isogram_chars([_]).
% as is an empty list
isogram_chars([]).
% recursion
isogram_chars([H|T]) :-
    % H is not repeated in T
    (\+ member(H, T);
    % or H is not a letter
    % http://www.swi-prolog.org/pldoc/man?predicate=char_type/2
     \+ char_type(H,alnum)),
    % and T is an isogram
    isogram_chars(T).