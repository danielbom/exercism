% contribution(Number, Factors, Result)
% Result is Number if Number is divisible by one of Factors, 0 otherwise
contribution([], _Number, 0).
contribution([Factor | Rest], Number, Result) :-
  0 is Number mod Factor, Result is Number, ! ;
  contribution(Rest, Number, Result).

% Summing with accumulator, to have tail recursion
sum_of_multiples_with_acc(_Factors, 0, Acc, Acc) :- !.
sum_of_multiples_with_acc(Factors, Limit, Acc, Sum) :-
  contribution(Factors, Limit, C),
  NewAcc is Acc + C,
  NewLimit is Limit - 1,
  sum_of_multiples_with_acc(Factors, NewLimit, NewAcc, Sum).

sum_of_multiples(_Factors, 0, 0) :- !.
sum_of_multiples([], _Limit, 0) :- !.  % Optional shortcut, may be removed.
sum_of_multiples(Factors, Limit, Sum) :-
  First is Limit - 1,  % ...since the limit itself must not be included
  sum_of_multiples_with_acc(Factors, First, 0, Sum).

% vim:sw=2:sts=2:ft=prolog
