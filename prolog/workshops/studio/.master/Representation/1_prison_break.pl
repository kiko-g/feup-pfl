/*
male(x).
x is male.
*/
male('Aldo Burrows').
male('Lincoln Burrows').
male('Michael Scofield').
male('LJ Burrows').

/*
female(x).
x is female.
*/
female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

/*
parent(x, y).
x is parent of y.
*/
parent('Christina Rose Scofield', 'Lincoln Burrows').
parent('Aldo Burrows', 'Lincoln Burrows').
parent('Christina Rose Scofield', 'Michael Scofield').
parent('Aldo Burrows', 'Michael Scofield').
parent('Lisa Rix', 'LJ Burrows').
parent('Lincoln Burrows', 'LJ Burrows').
parent('Michael Scofield', 'Ella Scofield').
parent('Sara Tancredi', 'Ella Scofield').

/*
parents(Child, Dad, Mom).
Finds Dad and Mom of Child.
*/
parents(Child, Dad, Mom) :-
    male(Dad),
    female(Mom),
    parent(Dad, Child),
    parent(Mom, Child).

/*
childs(Parent, Child).
Finds childs of parent.
*/
childs(Parent, Child) :-
    parent(Parent, Child).

/*
a) parents('Michael Scofield', Dad, Mom).
b) childs('Aldo Burrows', Child).
*/