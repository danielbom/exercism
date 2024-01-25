:- use_module(library(dcg/basics)).
encode(Plaintext, Ciphertext) :-
    string_chars(Plaintext, Chars),
    clumped(Chars, Groups),
    maplist(enc_group, Groups, EncGroups),
    flatten(EncGroups, CipherChars),
    string_chars(Ciphertext, CipherChars).

enc_group(X-1, [X]) :- !.
enc_group(X-N, [Str, X]) :- atom_number(NS, N), string_chars(NS, Str).

decode(Ciphertext, Plaintext) :-
    string_chars(Ciphertext, CipherChars),
    decode_groups(CipherChars, Groups),
    unroll_groups(Groups, PlainChars),
    string_chars(Plaintext, PlainChars).

decode_groups([], []) :- !.
decode_groups([X | Xs], [X-1 | Ys]) :- \+ is_digit(X), decode_groups(Xs, Ys), !.
decode_groups(In, [X-N | Ys]) :- phrase(integer(N), In, [X | Xs]), decode_groups(Xs, Ys).

unroll_groups([], []) :- !.
unroll_groups([X-1 | Xs], [X | Ys]) :- unroll_groups(Xs, Ys), !.
unroll_groups([X-N | Xs], [X | Ys]) :- succ(NN, N), unroll_groups([X-NN | Xs], Ys).
