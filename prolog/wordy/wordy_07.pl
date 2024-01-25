:- use_module(library(clpfd)).

try_intify([], []) :- !.
try_intify([Hd|Tl], [Num|Rest]) :-
    atom_number(Hd, Num),
    try_intify(Tl, Rest), !.
try_intify([Hd|Tl], [Hd|Rest]) :-
    try_intify(Tl, Rest), !.

evaluate([Num], Num) :- !.
evaluate([Lhs,'plus', Rhs|Rest], Result) :-
    catch(Tmp #= Lhs + Rhs, _, throw(error(syntax_error, "Not a number"))), !,
    evaluate([Tmp|Rest], Result), !.
evaluate([Lhs,'minus', Rhs|Rest], Result) :-
    catch(Tmp #= Lhs - Rhs, _, throw(error(syntax_error, "Not a number"))), !,
    evaluate([Tmp|Rest], Result), !.
evaluate([Lhs,'multiplied','by', Rhs|Rest], Result) :-
    catch(Tmp #= Lhs * Rhs, _, throw(error(syntax_error, "Not a number"))), !,
    evaluate([Tmp|Rest], Result), !.
evaluate([Lhs,'divided','by',Rhs|Rest], Result) :-
    catch(Tmp #= Lhs div Rhs, _, throw(error(syntax_error, "Not a number"))), !,
    evaluate([Tmp|Rest], Result), !.
evaluate([_, Other|_], _) :-
    atom(Other),
    Other \= 'plus',
    Other \= 'minus',
    Other \= 'divided',
    Other \= 'multiplied',
    throw(error(unknown_operation_error, Other)), !.
evaluate(L, _) :- throw(error(syntax_error, L)).

wordy(Question, Answer) :-
    (Question \= "What is?"; throw(error(syntax_error, "No question"))), !,
    (atom_concat(RStripped, '?', Question); throw(error(unknown_operation_error, Question))), !,
    (atom_concat('What is ', Stripped, RStripped); throw(error(unknown_operation_error, Question))), !,
    atomic_list_concat(Words, ' ', Stripped),
    try_intify(Words, IWords),
    evaluate(IWords, Answer).
