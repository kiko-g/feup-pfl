/*
pilot(x).
x is a pilot.
*/
pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

/*
team(x, y).
x is of team y.
*/
team('Lamb', 'Breitling').
team('Besenyei', 'Red Bull').
team('Chambliss', 'Red Bull').
team('MacLean', 'Mediterranean Racing Team').
team('Mangold', 'Cobra').
team('Jones', 'Matador').
team('Bonhomme', 'Matador').

/*
plane(x, y).
x has plane of model y.
*/
plane('Lamb', 'MX2').
plane('Besenyei', 'Edge540').
plane('Chambliss', 'Edge540').
plane('MacLean', 'Edge540').
plane('Mangold', 'Edge540').
plane('Jones', 'Edge540').
plane('Bonhomme', 'Edge540').

/*
circuit(x).
x is a circuit.
*/
circuit('Istanbul').
circuit('Budapest').
circuit('Porto').

/*
playerWon(x, y).
pilot x won on circuit y.
*/
playerWon('Jones', 'Porto').
playerWon('Mangold', 'Budapest').
playerWon('Mangold', 'Istanbul').

/*
gates(x,y).
circuit x has y gates.
*/
gates('Istanbul', 9).
gates('Budapest', 6).
gates('Porto', 5).

/*
teamWon(Team, Circuit).
team Team has a pilot which one Circuit.
*/
teamWon(Team, Circuit) :-
    team(Pilot, Team),
    playerWon(Pilot, Circuit).

/*
wonManyCircuits(Pilot).
Finds pilots which have won many circuits.
*/
wonManyCircuits(Pilot) :-
    playerWon(Pilot, C1),
    playerWon(Pilot, C2),
    circuit(C1),
    circuit(C2),
    C1 \= C2.

/*
bigCircuits(C).
Finds circuits with more than 8 gates.
*/
bigCircuit(C) :-
    circuit(C),
    gates(C, NumGates),
    NumGates > 8.

/*
noEdge540Pilots(Pilot).
Find pilots which do not fly in a Edge540
*/
noEdge540Pilots(Pilot) :-
    pilot(Pilot),
    \+ plane(Pilot, 'Edge540').

/*
Answers to exercises:

a) playerWon(Player, 'Porto').
b) teamWon(Team, 'Porto').
c) wonManyCircuits(Pilot).
d) bigCircuit(Circuit).
e) noEdge540Pilots(Pilot).
*/