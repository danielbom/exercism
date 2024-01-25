rna_map('C', 'G').
rna_map('G', 'C').
rna_map('T', 'A').
rna_map('A', 'U').

rna_transcription(Rna, Dna) :-
  string_chars(Rna, RnaList),
  maplist(rna_map, RnaList, DnaList),
  string_chars(Dna, DnaList).
