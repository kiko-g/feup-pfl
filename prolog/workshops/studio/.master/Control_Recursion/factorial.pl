factorial(0, 1).
factorial(1, 1).
factorial(N, Result) :-
    N > 1,
    factorial(N-1, Y),
    Result is N * Y.


factorial2(N, F) :-
    fact_acc(N, F, 1).

fact_acc(0, F, F).
fact_acc(1, F, F).
fact_acc(N, F, Acc) :-
    N > 1,
    fact_acc(N-1, F, Acc * N).