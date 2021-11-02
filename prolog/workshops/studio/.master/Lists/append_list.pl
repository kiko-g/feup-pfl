append_list([], L, L).
append_list([X|L1], L2, [X|L3]) :- append_list(L1, L2, L3).