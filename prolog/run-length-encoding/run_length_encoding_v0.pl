:- use_module(library(dcg/basics)).

encode(Plaintext, Ciphertext) :-
  string_chars(Plaintext, Chars),
  maplist([Ch, Ch-1] >> true, Chars, Pairs),
  group_pairs_by_key(Pairs, Grouped),
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

encode_group(Ch-[1], R) :-
  string_concat(Ch, "", R), !.
encode_group(Ch-Ones, R) :-
  length(Ones, OnesCount),
  number_string(OnesCount, Count),
  string_concat(Count, Ch, R).

decode_group(Ch-1, R) :-
  string_concat(Ch, "", R), !.
decode_group(Ch-Count, R) :-
  length(Chs, Count),
  maplist(=(Ch), Chs),
  atomics_to_string(Chs, R).
