:- include('db.pl').

wasPatient(1, [120 | _]).
wasPatient(Juri, [_ | Rest]) :- 
    NextJuri is Juri-1,
    wasPatient(NextJuri, Rest).

countPatienceHelper(JuriMember, Res, Seen) :-
    participant(Part, _, _),
    \+member(Part, Seen),    
    append([Part], Seen, NewSeen),

    countPatienceHelper(JuriMember, RecursiveRes, NewSeen),

    (
        performance(Part, Performances),
        wasPatient(JuriMember, Performances),
        Res is RecursiveRes+1;
        Res is RecursiveRes
    ),!.

countPatienceHelper(_, 0, _) :- !.

countPatience(JuriMember, Res) :-
    countPatienceHelper(JuriMember, Res, []).

patientJuri(JuriMember) :-
    countPatience(JuriMember, P),
    P >= 2.