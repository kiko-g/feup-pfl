% :- use_module(library(lists)).
:- dynamic male/1, female/1, parents/3.

% 1. Family
% a)
add_person:-
  read(Gender-Person),
  \+male(Person), \+female(Person),
  add_person_handler(Gender, Person).
add_person:- write('Person already exists'), fail.

add_person_handler(Gender,Person):- Gender = male, assert(male(Person)).
add_person_handler(Gender,Person):- Gender = female, assert(female(Person)).
add_person_handler(_,_):- write('Gender should be male or female'), fail.

% b)
add_parents(Person):-
  read(Father-Mother),
  \+parents(Father, Mother, Person),
  assert(parents(Father, Mother, Person)).
add_parents(_):- write('Parents already exist for given person'), fail.

% c)
remove_person:-
  read(Gender-Person),
  (Gender = male ; Gender = female),
  remove_person_handler(Gender, Person).
remove_person:- write('Gender should be male or female'), fail.

remove_person_handler(Gender, Person):-
  (Gender = male ; Gender = female),
  retractall(male(Person)),
  retractall(parents(Person, _, _)),
  retractall(parents(_, Person, _)),
  retractall(parents(_, _, Person)).


% 2. Flights
% flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

% a)
get_all_nodes(ListOfAirports):-
  findall(X, flight(X, _, _, _, _, _), L1),
  findall(Y, flight(_, Y, _, _, _, _), L2),
  append(L1, L2, L),
  sort(L,ListOfAirports).

% b)
count_occurrences(_, [], 0).
count_occurrences(X, [X|T], N1) :- !, count_occurrences(X, T, N), N1 is N+1.
count_occurrences(X, [_|T], N1) :- count_occurrences(X, T, N1).

most_diversified(Company):-
  findall(C, flight(_, _, C, _, _, _), Os),
  sort(Os, Cs),
  most_diversified_aux(Os, Cs, [], COs),
  sort(1, @>=, COs, [_-Company | _]).

most_diversified_aux(_, [], R, R).
most_diversified_aux(Os, [C|Cs], COs, COsResult):-
  count_occurrences(C, Os, N),
  most_diversified_aux(Os, Cs, [N-C | COs], COsResult).
