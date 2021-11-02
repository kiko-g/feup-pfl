list_until(N, L) :- list_seq(1, N, L).

list_seq(X, Y, []) :- X > Y.
list_seq(Curr, Max, [Curr | L]) :-
    Curr =< Max,
    Next is Curr+1,
    list_seq(Next, Max, L).

list_between(N1, N2, L) :- list_seq(N1, N2, L).

/*
list_sum([], 0).
list_sum([H|T], S) :-
    Sum is H+S,
*/


/*
list_between(N1, N2, L).

list_bet(X, N1, N2, []) :- X > N2.
list_bet(Curr, Min, Max, [Curr | L]) :-
    Curr =< Max
    */