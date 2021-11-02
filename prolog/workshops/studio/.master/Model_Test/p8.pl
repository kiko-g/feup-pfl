:- include('db.pl').
:- use_module(library(lists)).

didNotClickButton([120|_]).
didNotClickButton([_| T]) :- didNotClickButton(T).

madeItThrough(Participant) :-
    participant(Participant, _, _),
    performance(Participant, L),
    didNotClickButton(L).

eligibleOutcome(Id, Perf, TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumlist(Times,TT).

sliceList(_, 0, []).
sliceList([Curr | Orig], Count, [Curr | Result]) :-
    N is Count-1,
    sliceList(Orig, N, Result).


nextPhase(N, Participants) :-
    setof(TT-Id-Perf, eligibleOutcome(Id, Perf, TT), EligibleResults),
    reverse(EligibleResults, SortedList),
    length(SortedList, L),
    L >= N,
    sliceList(SortedList, N, Participants).

