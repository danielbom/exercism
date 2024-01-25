tree_inorder_intersection(X, [X|Tail], [], Tail).
tree_inorder_intersection(X, [Y|Tail], [Y|LeftSide], RightSide) :-
 	tree_inorder_intersection(X, Tail, LeftSide, RightSide).

tree_traversals(nil, [], []) :- !.
tree_traversals(node(nil, X, nil), [X], [X]) :- !.
tree_traversals(node(TR, X, TL), Preorder, Inorder) :- 
    tree_traversals(TR, RightPreorder, RightInorder), 
    tree_traversals(TL, LeftPreorder, LeftInorder),
    append(RightInorder, [X|LeftInorder], Inorder),
    append([X|RightPreorder], LeftPreorder, Preorder), !.
tree_traversals(Tree, Preorder, Inorder) :- 
    [PreorderHead|PreorderTail] = Preorder,
    node(TreeLeft, PreorderHead, TreeRight) = Tree,
    tree_inorder_intersection(PreorderHead, Inorder, InorderLeft, InorderRight),
    subtract(PreorderTail, InorderRight, PreorderLeft),
    subtract(PreorderTail, InorderLeft, PreorderRight),
    tree_traversals(TreeLeft, PreorderLeft, InorderLeft),
    tree_traversals(TreeRight, PreorderRight, InorderRight).
