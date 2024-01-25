isogram(Word) :-
    string_lower(Word, Low),
    string_chars(Low, Cs),
    include(\=(' '), Cs, Cs1),
    include(\=('-'), Cs1, Cs2),
    sort(Cs2, I),
    msort(Cs2, I).