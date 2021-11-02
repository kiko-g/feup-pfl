% 9a
substitute(_, _, [], []).
substitute(X, Y, [X | L1], [Y | L2]) :- substitute(X, Y, L1, L2).
substitute(X, Y, [Z | L1], [Z | L2]) :- 
    X \= Z,
    substitute(X, Y, L1, L2).

% 9b
/*
Remove duplicates that are in sequence
Not what was asked for.
*/
remove_duplicates_in_seq([X], [X]).
remove_duplicates_in_seq([X, X | L1], L2) :- remove_duplicates_in_seq([X | L1], L2).
remove_duplicates_in_seq([X, Y | L1], [X | L2]) :-
    X \= Y,
    remove_duplicates_in_seq([Y | L1], L2).

/*
Remove duplicates in any order
*/
find(X,L) :- append(_, [X|_], L).

remove_duplicates(L, Lres) :- remove_dupls(L, [], Lres).

remove_dupls([], _, []).
remove_dupls([X|L], Seen, Lres) :- 
    find(X, Seen),
    remove_dupls(L, Seen, Lres).
remove_dupls([X|L], Seen, [X|Lres]) :- 
    \+find(X, Seen),
    remove_dupls(L, [X|Seen], Lres).
