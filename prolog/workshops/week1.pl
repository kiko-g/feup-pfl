clear :-
    write('\033\[H\033\[2J').
not(X) :-
    \+ X.

/* 1. Relações familiares */
% a) database
female(grace).
female(haley).
female(dede).
female(gloria).
female(merle).
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
male(barb).
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
b1:- female(haley).
b2:- male(gil).
b3:- parent(frank, phil).
b4(X):- parent(X, claire).
b5(X):- parent(gloria, X).
b6(X):- parent(jay, Child), parent(Child, X).
b7(X):- parent(X, Parent), parent(Parent, lily).
b8:- parent(alex, _).