%% true if N is a multiple of some number in the list Ms
multiple_of(Ms, N) :-
    once((member(M, Ms), 0 is N mod M)).

%% Given a number, find the sum of all the multiples of particular
%% numbers up to but not including that number.
sum_of_multiples(ParticularNs, Limit, Sum) :-
    succ(L0, Limit),
    findall(M, (between(1, L0, M), multiple_of(ParticularNs, M)), Multiples),
    sumlist(Multiples, Sum).
