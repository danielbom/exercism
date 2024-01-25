sum_of_multiples(Factors, Limit, Sum) :-
  aggregate_all(sum(Factor), multiples_up_to(Factors, Limit, Factor), Sum).

multiples_up_to(Factors, Limit, Multiple) :-
  succ(InclusiveLimit, Limit),
  between(1, InclusiveLimit, Multiple),
  once((member(Factor, Factors), Multiple mod Factor =:= 0)).

% Earlier attempts below! Kept to demonstrate how far I've come.
% sum_of_multiples(Factors, Limit, Sum) :-
%   % Note because I've opted to use query solutions rather than a list, the "no solutions" case
%   % results in fail, rather than an empty list. So just add a cut and an disjuction ";" to catch it.
%   %(aggregate(sum(Factor), factors_up_to(Factors, Limit, Factor), Sum), !); Sum = 0.
%   % Or equivalently, with "once", which probably only turns out nicer if you have a separate rule.
%   %once(aggregate(sum(Factor), factors_up_to(Factors, Limit, Factor), Sum); Sum = 0).
%   % A comment on this equivalence: https://stackoverflow.com/questions/25346189/prolog-disjunction#comment134537780_42843240
%   % I since realised that `aggregate_all` produces an empty list instead of failing. So that will do:
%   aggregate_all(sum(Factor), factors_up_to(Factors, Limit, Factor), Sum).

% factors_up_to(Factors, Limit, Factor) :-
%   succ(InclusiveLimit, Limit),
%   between(1,InclusiveLimit,Factor),
%   %maplist(is_factor(Factor), Factors).
%   % Oh boy, spent way too long trying to find a "maplist" which succeeds if at least one
%   % element succeeds. Went on an awful trip through "forall" looking for a "forany", trying
%   % "\+" and "once" and "include" and "aggregate_all" via the official docs and getting nowhere.
%   % Finally happened on the exact question on SO and decided to just DIY it in two lines.
%   % https://stackoverflow.com/q/49504071/3697870
%   is_factor(Factor, Factors).

% is_factor(X,[Y|_])  :- X mod Y =:= 0, !.
% is_factor(X,[_|Ys]) :- is_factor(X, Ys).