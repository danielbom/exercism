:- use_module(library(clpfd)).

% use to check that a queen has valid position
% (row and col are 0-indexed)
create((A,B)) :-
    [A,B] ins 0..7.

attack((A,B), (A1,B1)) :-
    create((A,B)), create((A1,B1)),
    (   A #= A1 % attack on row
    ;   B #= B1 % attack on col
    ;   abs(A-A1) #= abs(B-B1) % diagonal attack
    ).
