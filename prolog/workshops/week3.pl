% 1. Cut functionality
s(1).
s(2) :- !.
s(3).

% a) s(X).
% b) s(X), s(Y).
% a) s(X), !, s(Y).

% 2. Cut effect
data(one).
data(two).
data(three).

cut_test_a(X) :- data(X).
cut_test_a('five').

cut_test_b(X) :- data(X), !.
cut_test_b('five').

cut_test_c(X, Y) :- data(X), !, data(Y).
cut_test_c('five').

/*
a) cut_test_a(X), write(X), nl, fail. 
one two three five

b) cut_test_b(X), write(X), nl, fail.
one

c) cut_test_c(X, Y), write(X-Y), nl, fail.
one-one one-two one-three
*/

% 3 Cut colors
person(afonso).
person(bruno).

age(afonso, 17).
age(bruno, 19).

immature(X):- adult(X), !, fail.
immature(_X).
adult(X):- person(X), !, age(X, N), N >=18.

/*
- The first cut is green.
- The second cut is red. If the first person found isn't >= 18 it fails. 
If the predicate didn't have a cut the predicate could succeed by backtracking.
*/

% 4) Input and output
% a) print_n(+S, +N)
print_n(_, 0).
print_n(Symbol, N) :-
    write(Symbol),
    NextN is N-1,
    print_n(Symbol, NextN).

% c) print_banner(+Text, +Symbol, +Padding)
% print_banner("Olá Mundo!", '*', 4).
print_banner(Text, Symbol, Padding) :-
    string_length(Text, NText),
    NRow1_5 is 2+Padding*2+NText,
    NRow2_4 is Padding*2+NText,
    print_n(Symbol, NRow1_5),
    nl,
    print_n(Symbol, 1),
    print_n(' ', NRow2_4),
    print_n(Symbol, 1),
    nl,
    write(Symbol),
    print_n(' ', Padding),
    write(Text),
    print_n(' ', Padding),
    write(Symbol),
    nl,
    print_n(Symbol, 1),
    print_n(' ', NRow2_4),
    print_n(Symbol, 1),
    nl,
    print_n(Symbol, NRow1_5),
    nl.

% 7)
% class(Course, ClassType, DayOfWeek, Time, Duration)
class(pfl, t, '1 Seg', 11, 1).
class(pfl, t, '4 Qui', 10, 1).
class(pfl, tp, '2 Ter', 10.5, 2).
class(lbaw, t, '1 Seg', 8, 2).
class(lbaw, tp, '3 Qua', 10.5, 2).
class(ltw, t, '1 Seg', 10, 1).
class(ltw, t, '4 Qui', 11, 1).
class(ltw, tp, '5 Sex', 8.5, 2).
class(fsi, t, '1 Seg', 12, 1).
class(fsi, t, '4 Qui', 12, 1).
class(fsi, tp, '3 Qua', 8.5, 2).
class(rc, t, '4 Qui', 8, 2).
class(rc, tp, '5 Sex', 10.5, 2).

% a) same_day(+UC1, +UC2)
same_day(UC1, UC2):-
    class(UC1, _, Day, _, _),
    class(UC2, _, Day, _, _).

% b) daily_courses(+Day, -Courses)
daily_courses(Day, Courses):-
    findall(UC, class(UC, _, Day, _, _), Courses).

% c) short_classes(-L)
short_classes(L):-
    findall(UC-Day/Time, (
        class(UC, _, Day, Time, Duration), 
        Duration < 2
    ), L).

% d) course_classes(+UC, -Classes)
course_classes(UC, Classes):-
    findall(Day-Time/Type, class(UC, Type, Day, Time, _), Classes).

% e) courses(-L)
courses(L):-
    findall(UC, class(UC, _, _, _, _), L1),
    sort(L1, L).

% f) schedule
schedule:-
    setof(Day-Time-Duration-UC-Type, class(UC, Type, Day, Time, Duration), L),
    print_schedule(L).

print_schedule([]).
print_schedule([Day-Time-Duration-UC-Type | Schedule]):-
    transform_day(Day, DayF),
    format('~s (~s): ~s ~2f (~2f h)', [UC, Type, DayF, Time, Duration]), nl,
    print_schedule(Schedule).

% g) 
transform_day(Str, DayF):-
    atom_chars(Str, [_,_| DayList]),
    atom_chars(DayF1, DayList),
    downcase_atom(DayF1, DayF).
