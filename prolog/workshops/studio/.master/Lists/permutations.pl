permutation(L1,L2) :-
    permut(L1,L2),
    permut(L2,L1).

permut([], _).
permut([H|Rest], L2) :-
    member(H, L2),
    permut(Rest, L2).