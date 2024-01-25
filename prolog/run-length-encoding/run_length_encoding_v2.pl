:- use_module(library(dcg/basics)).

encode(Plaintext, Ciphertext) :-
  string_chars(Plaintext, Chars),
  group_consecutive(Chars, Grouped),
  maplist(encode_group, Grouped, EncodedGroups),
  atomics_to_string(EncodedGroups, Ciphertext).

decode(Ciphertext, Plaintext) :-
  string_chars(Ciphertext, Chars),
  once(phrase(decoded_groups(Groups), Chars)),
  maplist(decode_group, Groups, DecodedGroups),
  atomics_to_string(DecodedGroups, Plaintext).

decoded_groups([]) --> eol.
decoded_groups([Ch-Count | Rest]) --> number(Count), !, [Ch], decoded_groups(Rest).
decoded_groups([Ch-1 | Rest]) --> [Ch], decoded_groups(Rest).

encode_group(Chs, R) :-
  cipher(Ch-Count, Chs),
  cipher_count(Count, Value),
  string_concat(Value, Ch, R).

decode_group(Ch-Count, R) :-
  cipher(Ch-Count, Chs),
  atomics_to_string(Chs, R).

cipher(Ch-Count, [Ch | Chs]) :-
  length([Ch | Chs], Count),
  maplist(=(Ch), Chs).

cipher_count(N, S) :- 
  N > 1,
  number_string(N, S).
cipher_count(1, "").

group_consecutive([], []).
group_consecutive([X | Xs], [[X | Group] | RestGroups]) :-
  group_consecutive(Xs, X, Group, RestXs),
  group_consecutive(RestXs, RestGroups).

group_consecutive([], _, [], []) :- !.
group_consecutive([X | Xs], X, [X | Group], RestXs) :- !,
  group_consecutive(Xs, X, Group, RestXs).
group_consecutive(Xs, _, [], Xs).
