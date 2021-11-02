/* Exercise 2 | Red Bull Air Race

Questions
    a) Who won the Porto circuit?
    b) Which team won the Porto circuit? 
    c) Which pilots won more than 1 circuit?
    d) Which circuits have over 8 gates?
    e) What pilots don't pilot an Edge540?
Answers
    a) winning_pilot(X, 'Porto'). 
    b) winning_team(X, 'Porto').
    c) won_multiple_circuits(X).
    d) large_circuit(X).
    e) not_Edge540_pilot(X).
*/



% pilot(X).             X is a pilot
pilot('Lamb').
pilot('BesenYei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

% team(X, Y).               X is a pilot for team Y
team('Lamb', 'Breitling').
team('BesenYei', 'Red Bull').
team('Chambliss','Red Bull').
team('MacLean', 'Mediterranean Racing Team').
team('Mangold', 'Cobra').
team('Jones', 'Matador').
team('Bonhomme', 'Matador').

% plane(X, Y).              X drives plane Y
plane('Lamb', 'MX2').
plane('BesenYei', 'Edge540').
plane('Chambliss', 'Edge540').
plane('MacLean', 'Edge540').
plane('Mangold', 'Edge540').
plane('Jones', 'Edge540').
plane('Bonhomme', 'Edge540').

% circuit(X).               X is a circuit
circuit('Porto').
circuit('Istanbul').
circuit('Budapest').

% winning_pilot(X, Y).      pilot X won circuit Y 
winning_pilot('Jones', 'Porto').
winning_pilot('Mangold', 'Budapest').
winning_pilot('Mangold', 'Istanbul').

% circuit_gates(X, Y).      circuit X has Y gates.
circuit_gates('Porto', 5).
circuit_gates('Budapest', 6).
circuit_gates('Istanbul', 9).



winning_team(Team, Circuit):-
    team(Pilot, Team),
    winning_pilot(Pilot, Circuit).

won_multiple_circuits(Pilot):-
    winning_pilot(Pilot, Circuit1),
    winning_pilot(Pilot, Circuit2),
    circuit(Circuit1),
    circuit(Circuit2),
    Circuit1 \= Circuit2.

large_circuit(Circuit):-
    circuit(Circuit),
    circuit_gates(Circuit, Gates),
    Gates > 8.

not_Edge540_pilot(Pilot):-
    pilot(Pilot),
    \+ plane(Pilot, 'Edge540').
