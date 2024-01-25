abbreviate(Sentence, Acronym) :-
  split_string(Sentence, "\s-", "\s-_", Words),
  maplist(get_head, Words, MapListResult),
  atomics_to_string(MapListResult, AtomicsToStringResult),
  string_upper(AtomicsToStringResult, Acronym).

get_head(Word, H) :-
  string_chars(Word, [H|_]).
