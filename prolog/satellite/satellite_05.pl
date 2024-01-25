tree_trav(nil, PreEnd, InEnd, PreEnd, InEnd, _).
tree_trav(node(L, V, R), [V|Pre], In, PreEnd, InEnd, [_|Limit]) :-
    tree_trav(L, Pre, In, LeftPre, [V|RightIn], Limit),
    tree_trav(R, LeftPre, RightIn, PreEnd, InEnd, Limit).

tree_traversals(Tree, Preorder, Inorder) :-
    tree_trav(Tree, Preorder, Inorder, [], [], Inorder).