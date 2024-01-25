:- use_module(library(clpfd)).
% https://www.swi-prolog.org/pldoc/man?section=clpfd-sudoku
% https://medium.com/@m00nlight/prolog-clp-fd-solve-killer-sudoku-and-greater-killer-sudoku-c0e56bf05365
% https://github.com/m00nlight/miscellaneous-code/blob/master/clpfd-killer-sudoku/solver.pl

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
  maplist(cages_cells(Rows), Cages, CagesCells),
  sudoku(Rows),
  maplist(cages_constrain, CagesCells).

cages_constrain((Sum, Vs)) :-
  all_distinct(Vs),
  sum(Vs, #=, Sum).

% Problems
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
%% https://en.wikipedia.org/wiki/Killer_sudoku
killer_cages(2, Cages) :- 
  killer_cages_from_map(
    Cages,
    [ [a1, a1, b1, b1, b1, c1, d1, e1, f1]
    , [g1, g1, h1, h1, c1, c1, d1, e1, f1]
    , [g1, g1, i1, i1, c1, j1, k1, k1, f1]
    , [l1, m1, m1, i1, n1, j1, k1, o1, f1]
    , [l1, p1, p1, q1, n1, j1, o1, o1, u1]
    , [s1, p1, v1, q1, n1, r1, t1, t1, u1]
    , [s1, v1, v1, q1, w1, r1, r1, b2, b2]
    , [s1, x1, y1, w1, w1, a2, a2, b2, b2]
    , [s1, x1, y1, w1, z1, z1, z1, c2, c2]
    ],
    [ a1-3,  b1-15, c1-22, d1-4
    , e1-16, f1-15, g1-25, h1-17
    , i1-9,  j1-8,  k1-20, l1-6
    , m1-14, n1-17, o1-17, p1-13
    , q1-20, r1-20, s1-27, t1-6
    , u1-12, v1-6,  w1-10, x1-8
    , y1-16, z1-13, a2-15, b2-14
    , c2-17
    ]
  ).
%% https://www.dailykillersudoku.com/pdfs/17391.pdf
killer_cages(3, Cages) :- 
  killer_cages_from_map(
    Cages,
    [ [a, a, b, b, c, c, d, d, d ]
    , [a, e, f, f, c, c, g, h, h ]
    , [e, e, f, k, c, g, g, i, i ]
    , [e, j, j, k, l, l, g, i, m ]
    , [n, o, o, l, l, l, p, p, m ]
    , [n, q, r, l, l, s, t, t, u ]
    , [q, q, r, r, v, s, w, u, u ]
    , [x, x, r, v, v, w, w, u, a1]
    , [y, y, y, v, v, z, z, a1,a1]
    ],
    [ a-14, b-13, c-22, d-17, e-20
    , f-15, g-15, h-15, i-15, j-8
    , k-14, l-30, m-12, n-13, o-7
    , p-12, q-11, r-19, s-11, t-10
    , u-16, v-30, w-21, x-13, y-12
    , z-7, a1-13
    ]
  ).

killer_cages_from_map(Cages, GridKeys, Sums) :-
  list_to_assoc(Sums, SumsAssoc),
  append(GridKeys, Keys),
  grid_indexes(Indexes),
  pairs_keys_values(Pairs, Keys, Indexes),
  sort(1, @>=, Pairs, SortedPairs),
  group_pairs_by_key(SortedPairs, Groups),
  merge_sums_indexes(Groups, SumsAssoc, Cages).

merge_sums_indexes([], _, []).
merge_sums_indexes([K-Vs | Tail], Sums, [(Sum, Vs) | Cages]) :-
  get_assoc(K, Sums, Sum),
  merge_sums_indexes(Tail, Sums, Cages).

grid_indexes(Result) :-
  findall((Y, X), (between(0, 8, Y), between(0, 8, X)), Result).

cages_cells(Rows, (Sum, Cages), (Sum, Cells)) :-
  maplist(cage_cell(Rows), Cages, Cells).

cage_cell(Rows, (Y, X), Cell) :-
  nth0(Y, Rows, Row),
  nth0(X, Row, Cell).

cages_collect_cells(_, [], []).
cages_collect_cells(Rows, [Cage | Cages], [Cell | Result]) :-
  cage_cell(Cage, Cell),
  cages_collect_cells(Rows, Cages, Result).

cages_see(Rows, Cages) :-
  length(Rows, 9),
  maplist(same_length(Rows), Rows),
  cages_see_go(Rows, Cages), !.

cages_see_go(Rows, []) :-
  maplist(fill_zero, Rows).
cages_see_go(Rows, [(Sum, Cage) | Cages]) :-
  cages_collect_cells(Rows, Cage, Cells),
  maplist(=(Sum), Cells),
  cages_see(Rows, Cages).

fill_zero([]).
fill_zero([0 | Tail]) :- fill_zero(Tail), !.
fill_zero([_ | Tail]) :- fill_zero(Tail).

compare_by_length(Order, (_, List1), (_, List2)) :-
  length(List1, Length1),
  length(List2, Length2),
  compare(Order, Length1, Length2).

solve_sudoku_killer(Num) :-
  killer_cages(Num, Cages),
  killer_sudoku(Rows, Cages),
  maplist(label, Rows),
  maplist(portray_clause, Rows),
  halt.