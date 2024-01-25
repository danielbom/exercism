split_at(P, [P|T], [], T).
split_at(P, [X|T], L, R) :-
  split_at(P, T, LTail, R),
  L = [X|LTail].

tree_traversals(nil, [], []).
tree_traversals(node(TreeL, Head, TreeR), [Head|PreTail], Post) :-
  split_at(Head, Post, PostL, PostR),
  subtract(PreTail, PostR, PreL),
  subtract(PreTail, PostL, PreR),
  tree_traversals(TreeL, PreL, PostL),
  tree_traversals(TreeR, PreR, PostR).
