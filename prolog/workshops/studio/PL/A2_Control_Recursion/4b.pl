fib(0,1).
fib(1,1).
fib(N,X):-
    N > 1,
    fib(N-1, F1),
    fib(N-2, F2),
    F is X1 + X2.