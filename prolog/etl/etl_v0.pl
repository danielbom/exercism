transform(ScoreLetters, LetterScores) :-
  transform_letters(ScoreLetters, LettersScoreNested),
  flatten(LettersScoreNested, LettersScoreUnsorted),
  sort(LettersScoreUnsorted, LetterScores).

transform_letters([], []).
transform_letters([Value-Letters | Rest], [Pairs | Result]) :-
  maplist(letter_to_pair(Value), Letters, Pairs),
  transform_letters(Rest, Result).

letter_to_pair(Value, Letter, Atom-Value) :-
  string_lower(Letter, Lower),
  atom_string(Atom, Lower).
