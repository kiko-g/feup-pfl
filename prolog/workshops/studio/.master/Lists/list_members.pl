%a
membro(X, [X|_]).
membro(X, [_|T]) :- membro(X, T).

%b
membro(X,L) :- append(_, [X|_], L).

%c
last(L, X) :- append(_, [X | []], L).

%d
/*
    M - output variable for found element
    T - remaining list
*/
nth_member(1, [M|_], M). %if N is 1, return the current head
nth_member(N, [_|T], M) :-
    N > 1,
    N1 is N-1,
    nth_member(N1, T, M).