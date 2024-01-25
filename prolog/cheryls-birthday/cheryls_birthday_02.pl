candidate(may, 15).
candidate(may, 16).
candidate(may, 19).
candidate(june, 17).
candidate(june, 18).
candidate(july, 14).
candidate(july, 16).
candidate(august, 14).
candidate(august, 15).
candidate(august, 17).

has_unique_day(Month) :-
    candidate(Month, Day), 
    findall(Month1, candidate(Month1, Day), [_]).

statement1(Month, Day) :-
    candidate(Month, Day),
    \+ has_unique_day(Month).

statement2(Month, Day) :-
    candidate(Month, Day),
    findall(Month1, statement1(Month1, Day), [Month]).

statement3(Month, Day) :-
    candidate(Month, Day),
    findall(Day1, statement2(Month, Day1), [Day]).

cheryls_birthday(Month, Day) :-
    statement1(Month, Day),
    statement2(Month, Day),
    statement3(Month, Day),
    !.
