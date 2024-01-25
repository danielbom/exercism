can_chain([]).
can_chain([(X, Y) | Rest]) :-
    once(can_chain(X, Y, Rest)).

can_chain(X, X, []).
can_chain(Start, Next, Pieces) :-
    select(Piece, Pieces, Remaining),
    ((Next, Y) = Piece; (Y, Next) = Piece),
    can_chain(Start, Y, Remaining).
