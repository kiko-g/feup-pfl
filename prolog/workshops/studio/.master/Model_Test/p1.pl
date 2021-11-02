:- include('db.pl').

didNotClickButton([120|_]).
didNotClickButton([_| T]) :- didNotClickButton(T).

madeItThrough(Participant) :-
    participant(Participant, _, _),
    performance(Participant, L),
    didNotClickButton(L).