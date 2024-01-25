abbreviate(Sentence, Acronym) :-
  string_chars(Sentence, Chars),
  collect_acronym(Chars, AcronymList),
  atomics_to_string(AcronymList, AcronymLetters),
  string_upper(AcronymLetters, Acronym).

collect_acronym(Chars, Result) :-
  collect_acronym(Chars, Result, collect).

collect_acronym([Ch | Rest], [Ch | Result], collect) :-
  char_type(Ch, alpha), !,
  collect_acronym(Rest, Result, skip).
collect_acronym([_ | Rest], Result, collect) :- !,
  collect_acronym(Rest, Result, collect).
collect_acronym([Sep | Rest], Result, skip) :-
  sep(Sep), !,
  collect_acronym(Rest, Result, collect).
collect_acronym([_ | Rest], Result, skip) :- !,
  collect_acronym(Rest, Result, skip).
collect_acronym([], [], _).

sep(' ').
sep('-').

