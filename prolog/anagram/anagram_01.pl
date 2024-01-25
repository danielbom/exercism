string_permutation(String1, String2) :-
    string_lower(String1, String1Lower),
    string_lower(String2, String2Lower),
    String1Lower \= String2Lower,
    string_chars(String1Lower, Chars1),
    string_chars(String2Lower, Chars2),
    permutation(Chars1, Chars2).

anagram(Word, Options, Matching) :-
    include(string_permutation(Word), Options, Matching).