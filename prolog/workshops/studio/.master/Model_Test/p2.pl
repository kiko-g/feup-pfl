:- include('db.pl').

findTime(_, 1, [H | _], H).
findTime(Participant, Judge, [_ | Rest], Times) :-
    Judge >= 1,
    NextJudge is Judge-1,
    findTime(Participant, NextJudge, Rest, Times).

juriTimes([], _, [], 0).
juriTimes([Curr | Next], JuriMember, [CurrTime | RestTimes], Total) :-
    performance(Curr, PointsList),
    findTime(Curr, JuriMember, PointsList, CurrTime),
    juriTimes(Next, JuriMember, RestTimes, N),
    Total is N+CurrTime.