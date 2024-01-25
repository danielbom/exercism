transform([], []).
transform([H|T], LetterScores) :-
    Point-Letters = H,
    transform(T, Rest),
    foldl(convert(Point), Letters, Rest, Scores),
    msort(Scores, LetterScores).

convert(Point, Letter, Acc, R) :-
    string_lower(Letter, Lower),
    string_chars(Lower, Xs),
    [Char|_] = Xs,
    R = [Char-Point|Acc].
