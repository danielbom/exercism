two_fer(Dialogue):-
    two_fer("you", Dialogue).

two_fer(Name, Dialogue):-
    phrase(sentence(Name), Codes),
    string_codes(Dialogue, Codes).

sentence(Name) --> "One for ", Name, ", one for me.".
