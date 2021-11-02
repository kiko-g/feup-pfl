f(X,Y) :- Y is X*X.

mymap([], _, []).
mymap([C | R], Op, [TC | CR]) :-
    apply(Op, [C, TC]),
    mymap(R, Op, CR).

apply(P, LArgs) :- G =.. [P | LArgs], G.