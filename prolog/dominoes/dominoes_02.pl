can_chain([]):- !.
can_chain([(X,X)]):- !.
can_chain(List) :-
    select((X,Y), List, Rest),
    (select((Link,Y), Rest, RestM);select((Y,Link), Rest, RestM)),
    can_chain([(X,Link)|RestM]),!.
