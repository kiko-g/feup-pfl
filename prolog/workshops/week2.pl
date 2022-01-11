% 1. Recursion
% a) Fatorial
fatorial(0, 1).
fatorial(N, F) :-
    N>0,
    N1 is N-1,
    fatorial(N1, F1),
    F is N*F1.


% a) Fatorial Alternate
fatorialAltAux(1, F, F).
fatorialAltAux(N, F, NewF) :-
    NextN is N-1,
    NextF is N*F,
    fatorialAltAux(NextN, NextF, NewF).

fatorialAlt(N, F) :-
    N>0,
    fatorialAltAux(N, 1, F).

% b) Sum N
somaRec(0, 0).
somaRec(N, Sum) :-
    N>0,
    N1 is N-1,
    somaRec(N1, Sum1),
    Sum is Sum1+N.

% b) Sum N Alternate
somaRecAltAux(0, Sum, Sum).
somaRecAltAux(N, Sum, SumReturn) :-
    NextN is N-1,
    NextSum is N+Sum,
    somaRecAltAux(NextN, NextSum, SumReturn).

somaRecAlt(N, Sum) :-
    somaRecAltAux(N, 0, Sum).

% c) Fibonacci
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, Fib) :-
    N>1,
    N1 is N-1,
    N2 is N-2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    Fib is F1+F2.

% d) Is Prime
isPrimeAux(X, N):- N>1, X rem N =:= 0.
isPrimeAux(X, N):- N>1, Next is N-1, isPrimeAux(X, Next).

isPrime(1).
isPrime(X) :-
    N is X-1,
    \+ isPrimeAux(X, N).
