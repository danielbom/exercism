in_order(nil) --> [].
in_order(node(Left, Name, Right)) -->
    in_order(Left),
    [Name],
    in_order(Right).

pre_order(nil) --> [].
pre_order(node(Left, Name, Right)) -->
    [Name],
    pre_order(Left),
    pre_order(Right).

tree_traversals(Tree, Preorder, Inorder) :- 
    phrase(pre_order(Tree),Preorder),
    phrase(in_order(Tree),Inorder).
