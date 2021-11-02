:- include('db.pl').

getFansList([], _, []).

getFansList([120 | Next], JuriN, [JuriN | FanList]) :-
    NextJuri is JuriN+1,
    getFansList(Next, NextJuri, FanList).

getFansList([Curr | Next], JuriN, FanList) :-
    Curr \= 120,
    NextJuri is JuriN+1,
    getFansList(Next, NextJuri, FanList).

participantFanList(Participant, FanList) :-    
    performance(Participant, Performance),
    getFansList(Performance, 1, FanList).

juriFans(JuriFanList) :-
    bagof(Participant-FanList, participantFanList(Participant, FanList), JuriFanList).