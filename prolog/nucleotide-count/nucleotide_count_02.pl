% nucleotide_count(+Strand:atom, -Counts:list)
nucleotide_count(Strand, [('A', A), ('C', C), ('G', G), ('T', T)]) :-
    atom_chars(Strand, Ns),
    include(=('A'),Ns,As),length(As,A),
    include(=('C'),Ns,Cs),length(Cs,C),
    include(=('G'),Ns,Gs),length(Gs,G),
    include(=('T'),Ns,Ts),length(Ts,T),
    length(Ns, Nlen), Nlen is A+C+G+T.