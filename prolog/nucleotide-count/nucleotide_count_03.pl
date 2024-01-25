:- use_module(library(assoc)).

nucleotide_count(DNA, Counts) :-
  string_upper(DNA, UpDNA),
  string_to_list(UpDNA, ListDNA),
  new_count_assoc(NewCountAssoc),
  do_count(ListDNA, NewCountAssoc, CountAssoc),
  assoc_to_list(CountAssoc, CountPairs),
  maplist(pair_to_count, CountPairs, Counts).

do_count([], Counts, Counts).
do_count([N | T], CountAcc, Counts) :-
  assoc_to_keys(CountAcc, Ns),
  member(N, Ns),
  get_assoc(N, CountAcc, Count),
  UpdateCount is Count+1,
  put_assoc(N, CountAcc, UpdateCount, UpdateAcc),
  do_count(T, UpdateAcc, Counts).

new_count_assoc(N) :-
  Ks = `ACGT`,
  maplist(zero_pair, Ks, KVs),
  list_to_assoc(KVs, N).

zero_pair(K, K-0).

pair_to_count(K-C, (S, C)) :-
  char_code(S, K).
