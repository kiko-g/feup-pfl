:- include('db.pl').

calcTime([], 0).
calcTime([CurrTime | Rest], Sum) :-
    calcTime(Rest, N),
    Sum is CurrTime+N.

bestParticipant(P1, P2, P) :-
    P1 \= P2,
    performance(P1, L1),
    performance(P2, L2),
    calcTime(L1, Sum1),
    calcTime(L2, Sum2),
    (
        Sum1 > Sum2, P is P1;
        P is P2
    ).