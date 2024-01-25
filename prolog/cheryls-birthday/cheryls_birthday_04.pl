possible_date(may, 15).
possible_date(may, 16).
possible_date(may, 19).
possible_date(june, 17). 
possible_date(june, 18).
possible_date(july, 14).
possible_date(july, 16). 
possible_date(august, 14).
possible_date(august, 15).
possible_date(august, 17).

% If given a month and day, Albert knows Bernard does not know (a date must have a non-unique day and the month does not contain a unique day)
statement_1(ValidDates) :- 
    findall((Month,Day), 
    % A day that is not unique
    ( possible_date(Month, Day)
    , possible_date(AnotherMonth, Day)
    , Month \= AnotherMonth
    % The month does not contain a unique day
    , forall(possible_date(Month, D), (possible_date(Other, D), Other \= Month))
    ) , ValidDates).

% Bernard knows if day is unique in valid dates list
bernard_know(ValidDates, Date) :-
    contains_term(Date, ValidDates),
    (Month, Day) = Date,
    forall((possible_date(M, Day),M \= Month,contains_term((M,Day),ValidDates)), false).

% Given remaining month and day, Bernard now know the date (must be a unique day)
statement_2(ValidDates1, ValidDates2) :-
    include(bernard_know(ValidDates1), ValidDates1, ValidDates2).

% Albert know if the month is unique in valid dates list
albert_know(ValidDates, Date) :-
    contains_term(Date, ValidDates),
    (Month, Day) = Date,
    forall((possible_date(Month, D), D \= Day,contains_term((Month,D),ValidDates)), false).

% Given remaining month and day, Albert now know the date (must be a unique month)
statement_3(ValidDates2, ValidDates3) :-
    include(albert_know(ValidDates2), ValidDates2, ValidDates3).

cheryls_birthday(Month,Day) :-
    statement_1(ValidDates1),
    statement_2(ValidDates1, ValidDates2),
    statement_3(ValidDates2, ValidDates3),
    [(Month, Day)] = ValidDates3.
