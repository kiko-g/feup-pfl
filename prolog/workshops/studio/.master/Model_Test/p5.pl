:- include('db.pl').

writePerformanceFirst([Curr| Rest]) :-
    put_char('['),
    write(Curr),
    put_char(','),
    writePerformance(Rest).

writePerformance([Last | []]) :-
    write(Last),
    put_char(']'),
    !.
    
writePerformance([Curr | Rest]) :-
    write(Curr),
    put_char(','),
    writePerformance(Rest).

printPerformances(Seen) :-
    participant(ID, _, PerfName),
    \+member(ID, Seen),    
    append([ID], Seen, NewSeen),

    (
        performance(ID, Perf),
        write(ID), put_char(':'), write(PerfName), put_char(':'), writePerformanceFirst(Perf), nl
        ;
        1=1
    ), !,
    printPerformances(NewSeen).
printPerformances(_) :- !.


allPerfs :-
    printPerformances([]).