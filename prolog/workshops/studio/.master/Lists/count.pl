%a
conta([], 0).
conta([_|T], N) :-
    N1 is N-1,
    conta(T, N1).

%b
conta_elem(_, [], 0).
conta_elem(X, [H|T], N) :-
    X = H,
    N1 is N-1,
    conta_elem(X, T, N1).
conta_elem(X, [H|T], N) :-
    X \= H,
    conta_elem(X, T, N).
