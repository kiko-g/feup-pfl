% Exercise 1 | Prison Break
male('Aldo Burrows').
male('Lincoln Burrows').
male('Michael Scofield').
male('LJ Burrows').

female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

parent('Aldo Burrows', 'Lincoln Burrows').
parent('Christina Rose Scofield', 'Lincoln Burrows').
parent('Aldo Burrows', 'Michael Scofield').
parent('Christina Rose Scofield', 'Michael Scofield').
parent('Lincoln Burrows', 'LJ Burrows').
parent('Lisa Rix', 'LJ Burrows').
parent('Michael Scofield', 'Ella Scofield').
parent('Sara Tancredi', 'Ella Scofield').


/*
a)  parent(X, 'Michael Scofield').
    X = 'Aldo Burrows' ? n
    X = 'Christina Rose Scofield' ? n
    no

b)  parent('Aldo Burrows', X).
    X = 'Lincoln Burrows' ? n
    X = 'Michael Scofield' ? n
    no

Format("valor = ~d ~f de ~p ~n", [10, 3.5, dinheiro])
d – INTEGER
f - FLOAT
p - PROLOG TERM
n - NEW LINE
*/