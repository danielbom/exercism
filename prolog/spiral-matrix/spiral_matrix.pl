matrix_add(N, Matrix, Result) :-
  maplist(maplist(plus(N)), Matrix, Result).

matrix_prepend([], [], []).
matrix_prepend([Head|Tail], [Row|TailMatrix], [[Head|Row]|TailResult]) :-
  matrix_prepend(Tail, TailMatrix, TailResult).

matrix_append([], [], []).
matrix_append([Head|Tail], [Row|TailMatrix], [NewRow|TailResult]) :-
  append(Row, [Head], NewRow),
  matrix_append(Tail, TailMatrix, TailResult).

gen_list(_, 0, []) :- !.
gen_list(Start, Count, [Start|ResultTail]) :-
  Next is Start + 1,
  Count1 is Count - 1,
  gen_list(Next, Count1, ResultTail).

gen_list_reversed(Start, Count, Result) :-
  gen_list(Start, Count, ResultReversed),
  reverse(ResultReversed, Result).

spiral(0, []) :- !.
spiral(1, [[1]]) :- !.
spiral(2, [[1, 2], [4, 3]]) :- !.
spiral(Size, Matrix) :-
  SideSize is Size - 2,
  RightStart is Size + 1,
  BottomStart is (Size * 2) - 1,
  LeftStart is BottomStart + Size,
  InnerStart is LeftStart + SideSize - 1,
  gen_list(1, Size, Top),
  gen_list(RightStart, SideSize, Right),
  gen_list_reversed(LeftStart, SideSize, Left),
  gen_list_reversed(BottomStart, Size, Bottom),
  spiral(SideSize, InnerMatrixBase),
  matrix_add(InnerStart, InnerMatrixBase, InnerMatrixStarted),
  matrix_prepend(Left, InnerMatrixStarted, InnerMatrixPrepended),
  matrix_append(Right, InnerMatrixPrepended, InnerMatrix),
  append([Top], InnerMatrix, TopMiddle),
  append(TopMiddle, [Bottom], Matrix).
