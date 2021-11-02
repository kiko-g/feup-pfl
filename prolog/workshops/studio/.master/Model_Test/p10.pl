impoe(X, L) :-
    length(Mid, X),
    append(L1, [X|_], L), append(_, [X|Mid], L1).