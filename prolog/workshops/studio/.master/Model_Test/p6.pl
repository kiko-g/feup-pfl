:- include('db.pl').

noClick([]).
noClick([120 | Rest]) :-
    noClick(Rest).

successfulParticipant(ID) :-
    performance(ID, Perf),
    noClick(Perf).

nSuccessfulParticipants(T) :-
    bagof(ID, successfulParticipant(ID), SucParts),
    length(SucParts, T).