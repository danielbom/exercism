:- use_module(library(clpfd)).
% https://www.swi-prolog.org/pldoc/man?section=clpfd-sudoku

% Sudoku Solver
sudoku(Rows) :-
	length(Rows, 9),
  maplist(same_length(Rows), Rows),
  append(Rows, Vs),
  Vs ins 1..9,
  transpose(Rows, Columns),
  maplist(all_distinct, Columns),
  maplist(all_distinct, Rows),
  Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
  blocks(As, Bs, Cs),
  blocks(Ds, Es, Fs),
  blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
  all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
  blocks(Ns1, Ns2, Ns3).

% Killer Sudoku Solver
killer_sudoku(Rows, Cages) :-
  maplist(killer_sudoku_cage(Rows), Cages),
  sudoku(Rows).

killer_sudoku_cage(_, (_, [])).
killer_sudoku_cage(Rows, (Sum, Cage)) :-
  collect_cage(Rows, Cage, Cells),
  sum(Cells, #=, Sum),
  killer_sudoku_cage(Rows, (Sum, Cage)).

collect_cage(Rows, Cage, Result) :-
  collect_cage(Rows, Cage, [], Result).

collect_cage(_, [], Result, Result).
collect_cage(Rows, [(Y, X) | Cage], Acc, Result) :-
  nth0(Y, Rows, Row),
  nth0(X, Row, Cell),
  collect_cage(Rows, Cage, [Cell | Acc], Result).

see_cages(Rows, Cages) :-
	length(Rows, 9),
  maplist(same_length(Rows), Rows),
  see_cages_go(Rows, Cages), !.

see_cages_go(Rows, []) :-
  maplist(fill_zero, Rows).
see_cages_go(Rows, [(Sum, Cage) | Cages]) :-
  collect_cage(Rows, Cage, Cells),
  maplist(=(Sum), Cells),
  see_cages(Rows, Cages).

fill_zero([]).
fill_zero([0 | Tail]) :-
  fill_zero(Tail), !.
fill_zero([_ | Tail]) :-
  fill_zero(Tail).

problem(0, [[_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,_,_,_,_]]).
problem(1, [[_,_,_,_,_,_,_,_,_],
            [_,_,_,_,_,3,_,8,5],
            [_,_,1,_,2,_,_,_,_],
            [_,_,_,5,_,7,_,_,_],
            [_,_,4,_,_,_,1,_,_],
            [_,9,_,_,_,_,_,_,_],
            [5,_,_,_,_,_,_,7,3],
            [_,_,2,_,1,_,_,_,_],
            [_,_,_,_,4,_,_,_,9]]).


killer_cages(1, [
	(7,  [(1, 6), (2, 6), (2, 7)]),
	(13, [(2, 5), (3, 5), (3, 6), (4, 6)]),
	(16, [(7, 5), (7, 6), (8, 4), (8, 5), (8, 6)]),
	(17, [(5, 2), (5, 3), (6, 1), (6, 2), (6, 3), (7, 2)]),
	(24, [(4, 8), (5, 8), (6, 8)]),
	(37, [(1, 0), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1), (3, 2), (4, 0)])
]).
