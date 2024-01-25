nucleotide('A', 1, 0, 0, 0).
nucleotide('C', 0, 1, 0, 0).
nucleotide('G', 0, 0, 1, 0).
nucleotide('T', 0, 0, 0, 1).

nucleotide_iter([], A, C, G, T, [('A', A), ('C', C), ('G', G), ('T', T)]).
nucleotide_iter([H|R], A, C, G, T, L) :-
    nucleotide(H, AP, CP, GP, TP),
    AN is A + AP,
    CN is C + CP,
    GN is G + GP,
    TN is T + TP,
    nucleotide_iter(R, AN, CN, GN, TN, L).

nucleotide_count(Str, Cnt) :-
    string_chars(Str, Chs),
    nucleotide_iter(Chs, 0, 0, 0, 0, Cnt).