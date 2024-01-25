sum_of_multiples(Factors, Limit, Sum) :-
    High is Limit - 1,
    findall(X, (between(1, High, X), member(F, Factors), 0 is X mod F), Xs),
    list_to_set(Xs, DeDup),
    sum_list(DeDup, Sum).
