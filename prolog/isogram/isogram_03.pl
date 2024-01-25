:- use_module(library(lists)).

isogram(String) :-
    string_lower(String, Lower),
    string_chars(Lower, Chars),
    delete(Chars, ' ', Spaceless),
    delete(Spaceless, '-', Hyphenless),
    is_set(Hyphenless).
