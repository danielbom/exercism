split(_, [], [], []).
split(X, [X|Xs], [], Xs).
split(X, [Y|Ys], [Y|Ls], Rs) :- split(X, Ys, Ls, Rs).

tree_traversals(nil, [], []).
tree_traversals(node(L, X, R), [X|Preorder], Inorder) :-
    split(X, Inorder, LInorder, RInorder),
    append(LPreorder, RPreorder, Preorder),
    tree_traversals(L, LPreorder, LInorder),
    tree_traversals(R, RPreorder, RInorder).
