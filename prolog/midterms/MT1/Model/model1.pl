:- use_module(library(lists)).

% 1
madeItThrough(Participant) :-
    participant(Participant, _, _),
    performance(Participant, Times),
    member(120, Times).

% 2
% juriTimes([1234,3423,3788,4865,8937], 4, Times, Total).
juriTimes([], _, [], 0).
juriTimes([Participant | RestParticipants], JuriMember, [Time | RestTimes], Total):-
    performance(Participant, JuriResults),
    findTime(Participant, JuriMember, JuriResults, Time),
    juriTimes(RestParticipants, JuriMember, RestTimes, N),
    Total is N+Time.

findTime(_, 1, [H | _], H).
findTime(Participant, Judge, [_ | Rest], Times) :-
    Judge >= 1,
    NextJudge is Judge-1,
    findTime(Participant, NextJudge, Rest, Times).

% 3
patientJuri(J) :-
    juriTimes([X, Y], J, [TX, TY], _),
    X =\= Y,
    TX =:= 120,
    TY =:= 120.

% 4
bestParticipant(P1, P2, P):-
    performance(P1, Times1),
    performance(P2, Times2),
    sumList(Times1, Result1),
    sumList(Times2, Result2),
    (
        (Result1 > Result2, P = P1);
        (Result1 < Result2, P = P2)
    ).

sumList([], 0).
sumList([H|T], Result):-
    sumList(T, ResultAux),
    Result is H + ResultAux.

% 5
allPerfs:-
    allPerfs([]).

allPerfs(Visited) :-
    performance(ID, _),
    \+(member(ID, Visited)), !,
    printPerformance(ID),
    allPerfs([ID|Visited]).
allPerfs(_).

printPerformance(ID) :-
    participant(ID, _, Performance),
    performance(ID, Times),
    format("~w:~w:~w", [ID, Performance, Times]), nl.

% extra
admirar(a, b).
admirar(c, d).
admirar(e, f).
admirar(a, f).
admirar(a, c).
admirar(e, b).
admirar(c, e).
admirar(b, d).
admirar(g, a).

ola(Total):-
    bagof(a, admira(a), L1),
    bagof(a, admiradoPor(a), L2),
    length(L1, T1),
    length(L2, T2),
    Total is T1+T2.

admira(Nome):-
    admirar(Nome, _).

admiradoPor(Nome):-
    admirar(_, Nome).

