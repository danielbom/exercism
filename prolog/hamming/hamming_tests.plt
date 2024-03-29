pending :-
    current_prolog_flag(argv, ['--all'|_]).
pending :-
    write('\nA TEST IS PENDING!\n'),
    fail.

:- begin_tests(hamming).

    test(identical_strands, condition(true)) :-
        hamming_distance("A", "A", Result),
            Result == 0.

    test(long_identical_strands, condition(pending)) :-
        hamming_distance("GGACTGA", "GGACTGA", Result), Result == 0.

    test(complete_distance_in_single_nucleotide_strands, condition(pending)) :-
        hamming_distance("A", "G", 1).

    test(complete_distance_in_small_strands, condition(pending)) :-
        hamming_distance("AG", "CT", Result), Result == 2.

    test(small_distance_in_small_strands, condition(pending)) :-
        hamming_distance("AT", "CT", Result), Result == 1.

    test(small_distance, condition(pending)) :-
        hamming_distance("GGACG", "GGTCG", Result), Result == 1.

    test(small_distance_in_long_strands, condition(pending)) :-
        hamming_distance("ACCAGGG", "ACTATGG", Result), Result == 2.

    test(nonunique_character_in_first_strand, condition(pending)) :-
        hamming_distance("AGA", "AGG", Result), Result == 1.

    test(nonunique_character_in_second_strand, condition(pending)) :-
        hamming_distance("AGG", "AGA", Result), Result == 1.

    test(same_nucleotides_in_different_positions, condition(pending)) :-
        hamming_distance("TAG", "GAT", Result), Result == 2.

    test(large_distance, condition(pending)) :-
        hamming_distance("GATACA", "GCATAA", Result), Result == 4.

    test(large_distance_in_offbyone_strand, condition(pending)) :-
        hamming_distance("GGACGGATTCTG", "AGGACGGATTCT", Result), Result == 9.

    test(empty_strands, condition(pending)) :-
        hamming_distance("", "", Result), Result == 0.

    test(disallow_first_strand_longer, [fail, condition(pending)]) :-
        hamming_distance("AATG", "AAA", _).

    test(disallow_second_strand_longer, [fail, condition(pending)]) :-
        hamming_distance("ATA", "AGTG", _).

:- end_tests(hamming).
