:- use_module(library(pcre)).

abbreviate(Sentence, Acronym) :-
    re_replace("[^a-zA-Z0-9\s-]"/g, "", Sentence, CleanSentence),
    split_string(CleanSentence, " -", " -", Words),
    maplist(first_letter, Words, FirstLetters),
    string_chars(LowercaseAcronym, FirstLetters),
    string_upper(LowercaseAcronym, Acronym).

first_letter(Word, FirstLetter) :-
    string_chars(Word, [FirstLetter|_]).