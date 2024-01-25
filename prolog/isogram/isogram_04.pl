is_alpha(C) :- char_type(C, 'alpha').

isogram(S) :- string_upper(S, S1),
    string_chars(S1, Chars),
    include(is_alpha, Chars, Letters),
    list_to_set(Letters, LS),
    length(Letters, N),
    length(LS, N).
