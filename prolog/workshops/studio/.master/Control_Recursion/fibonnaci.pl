fibonnaci(0,1).
fibonnaci(1,1).
fibonnaci(N,F) :-
    N > 1,
    N1 is N - 1, fibonnaci(N1,F1),
    N2 is N - 2, fibonnaci(N2,F2),
    F is F1 + F2.