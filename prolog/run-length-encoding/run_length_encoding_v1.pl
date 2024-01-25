:- use_module(library(dcg/basics)).

encode(Plaintext, Ciphertext) :-
  string_chars(Plaintext, Chars),
  count_consecutives(Chars, Grouped),
  maplist(encode_group, Grouped, Decoded),
  atomics_to_string(Decoded, Ciphertext).

decode(Ciphertext, Plaintext) :-
  string_chars(Ciphertext, Chars),
  once(phrase(decoded_groups(Groups), Chars)),
  maplist(decode_group, Groups, Undecoded),
  atomics_to_string(Undecoded, Plaintext).

decoded_groups([]) --> eol.
decoded_groups([Ch-Count | Rest]) --> number(Count), !, [Ch], decoded_groups(Rest).
decoded_groups([Ch-1 | Rest]) --> [Ch], decoded_groups(Rest).

count_consecutives([], []) :- !.
count_consecutives([Value | Values], Counts) :-
  count_consecutives(Values, Value, 1, Counts).

count_consecutives([], Value, Count, [Value-Count]) :- !.
count_consecutives([Value | Values], Value, Count, Counts) :- !,
  NextCount is Count + 1,
  count_consecutives(Values, Value, NextCount, Counts).
count_consecutives([NextValue | Values], Value, Count, [Value-Count | Counts]) :-
  \+ NextValue = Value,
  count_consecutives(Values, NextValue, 1, Counts).

encode_group(Ch-1, R) :-
  string_concat(Ch, "", R), !.
encode_group(Ch-Count, R) :-
  string_concat(Count, Ch, R).

decode_group(Ch-1, R) :-
  string_concat(Ch, "", R), !.
decode_group(Ch-Count, R) :-
  length(Chs, Count),
  maplist(=(Ch), Chs),
  atomics_to_string(Chs, R).
