two_fer(Name, Dialogue) :-
    string_concat("One for ", Name, X1),
    string_concat(X1, ", one for me.", X2),
    Dialogue = X2.
    
two_fer(Dialogue) :-
    two_fer("you", D),
    Dialogue = D.
