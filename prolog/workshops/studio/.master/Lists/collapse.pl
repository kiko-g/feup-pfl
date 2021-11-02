collapse([], []).
collapse(X, [X]) :- atomic(X).
collapse([Head|Rest], L) :-
    collapse(Head, L1),
    collapse(Rest, L2),
    append(L1, L2, L).