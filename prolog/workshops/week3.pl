% 1. Funcionamento do cut
s(1).
s(2) :- !.
s(3).

% a) s(X).
% b) s(X), s(Y).
% a) s(X), !, s(Y).
data(one).
data(two).
data(three).

cut_test_a(X) :-
    data(X).
cut_test_a(five).
cut_test_b(X) :-
    data(X), !.
cut_test_b(five).
cut_test_c(X, Y) :-
    data(X), !,
    data(Y).
cut_test_c(five).

% 4
print_n(_, 0).
print_n(Symbol, N) :-
    write(Symbol),
    NextN is N-1,
    print_n(Symbol, NextN).

% print_text("Olá Mundo!", '*', 4).
print_text(Text, Delimiter, Padding) :-
    string_length(Text, NText),
    NRow1_5 is 2+Padding*2+NText,
    NRow2_4 is Padding*2+NText,
    print_n(Delimiter, NRow1_5),
    nl,
    print_n(Delimiter, 1),
    print_n(' ', NRow2_4),
    print_n(Delimiter, 1),
    nl,
    write(Delimiter),
    print_n(' ', Padding),
    write(Text),
    print_n(' ', Padding),
    write(Delimiter),
    nl,
    print_n(Delimiter, 1),
    print_n(' ', NRow2_4),
    print_n(Delimiter, 1),
    nl,
    print_n(Delimiter, NRow1_5),
    nl.
