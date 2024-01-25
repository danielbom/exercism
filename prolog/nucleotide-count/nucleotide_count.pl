counter(_, [], R, R) :- !.
counter(X, [X|Rest], Acc, R) :-
    NextAcc is Acc + 1,
    counter(X, Rest, NextAcc, R), !.
counter(X, [_|Rest], Acc, R) :-
    counter(X, Rest, Acc, R), !.

nucleotide_count(Dna, Counts) :-
  string_chars("ACGT", Nucleotides),
  string_chars(Dna, Chars),
  subtract(Chars, Nucleotides, []),
  counter('A', Chars, 0, ACount),
  counter('C', Chars, 0, CCount),
  counter('G', Chars, 0, GCount),
  counter('T', Chars, 0, TCount),
  Counts = [('A', ACount), ('C', CCount), ('G', GCount), ('T', TCount)].
