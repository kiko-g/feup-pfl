% format('~w ~w\n', [X,Y]), fail.
clear :-
    write('\033\[H\033\[2J').

% 1. Relações familiares
% a) database
female(grace).
female(haley).
female(dede).
female(gloria).
female(barb).
female(claire).
female(pameron).
female(lily).
female(poppy).
female(cameron).
male(manny).
male(frank).
male(phil).
male(jay).
male(javier).
male(merle).
male(george).
male(dylan).
male(mitchell).
male(joe).
male(bo).
male(calhoun).
male(rexford).
male(luke).
male(alex).
parent(grace, phil).
parent(frank, phil).
parent(dede, claire).
parent(dede, mitchell).
parent(jay, claire).
parent(jay, mitchell).
parent(jay, joe).
parent(gloria, joe).
parent(gloria, manny).
parent(javier, manny).
parent(barb, cameron).
parent(barb, pameron).
parent(merle, cameron).
parent(merle, pameron).
parent(phil, haley).
parent(phil, alex).
parent(phil, luke).
parent(claire, haley).
parent(claire, alex).
parent(claire, luke).
parent(mitchell, lily).
parent(mitchell, rexford).
parent(cameron, lily).
parent(cameron, rexford).
parent(pameron, calhoun).
parent(bo, calhoun).
parent(dylan, poppy).
parent(dylan, george).
parent(haley, poppy).
parent(haley, george).

% b) questions
b1 :-
    female(haley).
b2 :-
    male(gil).
b3 :-
    parent(frank, phil).
b4(X) :-
    parent(X, claire). % findall(Parent, parent(Parent, claire), X).
b5(X) :-
    parent(gloria, X).
b6(X) :-
    parent(jay, Child),
    parent(Child, X).
b7(X) :-
    parent(X, Parent),
    parent(Parent, lily).
b8 :-
    parent(alex, _).
b9(X) :-
    parent(jay, X),
    \+ parent(gloria, X).

% c) relations
father(P, C) :-
    male(P),
    parent(P, C).

grandparent(GP, GC) :-
    parent(GP, P),
    parent(P, GC).

grandmother(GP, GC) :-
    grandparent(GP, GC),
    female(GP).

siblings(S1, S2) :-
    parent(P1, S1),
    parent(P1, S2),
    parent(P2, S1),
    parent(P2, S2),
    P1\=P2,
    S1\=S2,
    S1@<S2,
    P1@<P2.

halfSiblings(S1, S2) :-
    parent(P1, S1),
    parent(P1, S2),
    parent(P2, S1),
    parent(P3, S2),
    P2\=P1,
    P3\=P1,
    S1\=S2,
    P2\=P3.

cousins(X, Y) :-
    parent(P1, X),
    parent(P2, Y),
    siblings(P1, P2),
    \+ siblings(X, Y).

uncle(Uncle, Nephew) :-
    male(Uncle),
    siblings(Uncle, Parent),
    parent(Parent, Nephew).

% d) answers
d1 :-
    cousins(haley, lily).
d2(Dad) :-
    father(Dad, luke).
d3(Uncle) :-
    uncle(Uncle, lily).
d4(Grandma) :-
    grandmother(Grandma, _).
