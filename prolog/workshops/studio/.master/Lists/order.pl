sorted([_]).
sorted([X, Y | L]) :-
    X =< Y,
    sorted([Y|L]).