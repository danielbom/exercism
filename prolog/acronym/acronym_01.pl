abbreviate(Sentence, Acronym) :-
    % Split string to list of words
    split_string(
        Sentence,  % Input
        " -",  % Separator - Split by ' ' or '-'
        " -_",  % Padding  - Strip any additional ' ', '-' or '_' from words
        Words  % Result
    ),
    % Map list of words to list of each word's first character
    maplist(
        take_first,
        Words,  % Input
        AcronymChars  % Result
    ),
    % Concatenate characters to string
    string_chars(
        AcronymString,  % Result
        AcronymChars  % Input
    ),
    % Capitalised string and bind it to the result
    string_upper(AcronymString, Acronym).

take_first(Word, FirstChar) :-
    % Split word to list of characters and pattern match to bind the first to the result
    string_chars(Word, [FirstChar|_]).
