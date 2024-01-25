split([Item|Right], Item, [], Right).
split([Hd|Tl], Item, [Hd|Left], Right) :-
    split(Tl, Item, Left, Right).

split_length([], Rt, [], Rt).
split_length([_|Rest], [Hd|Src], [Hd|Lt], Rt) :-
    split_length(Rest, Src, Lt, Rt).

reconstruct(nil, [], []).
reconstruct(node(LtTree, Item, RtTree), [Item|Rest], Inorder) :-
    split(Inorder, Item, LtIn, RtIn),
    split_length(LtIn, Rest, LtPre, RtPre),
    reconstruct(LtTree, LtPre, LtIn),
    reconstruct(RtTree, RtPre, RtIn).

tree_traversals(Tree, Preorder, Inorder) :- 
    reconstruct(Tree, Preorder, Inorder).