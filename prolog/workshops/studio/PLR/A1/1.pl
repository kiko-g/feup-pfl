:-use_module(library(clpfd)).
:-use_module(library(lists)).

% 1.a)
quadrado_3x3(Board):-
    Board = [A1, A2, A3, A4, A5, A6, A7, A8, A9],
    domain(Board, 1, 9),
    all_distinct(Board),
    A1 + A2 + A3 #= A4 + A5 + A6,
    A7 + A8 + A9 #= A4 + A5 + A6,
    A1 + A4 + A7 #= A2 + A5 + A8,
    A2 + A5 + A8 #= A3 + A6 + A9,
    A1 + A5 + A9 #= A3 + A5 + A7,
    % A1 #< A2, A1 #< A3, A1 #< A4, A2 #< A4,   no symetric solutions
    labeling([], Board),
    write(Board), nl, fail. % write all solutions

quadrado_4x4(Board):-
    Board = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16],
    domain(Board, 1, 16),
    all_distinct(Board),
    % lines
    A1 + A2 + A3 + A4 #= A5 + A6 + A7 + A8,
    A5 + A6 + A7 + A8 #= A9 + A10 + A11 + A12,
    A9 + A10 + A11 + A12 #= A13 + A14 + A15 + A16,
    % columns
    A1 + A5 + A9 + A13 #= A2 + A6 + A10 + A14,
    A2 + A6 + A10 + A14 #= A3 + A7 + A11 + A15,
    A3 + A7 + A11 + A15 #= A4 + A8 + A12 + A16,
    % diagonal
    A1 + A6 + A11 + A16 #= A4 + A7 + A10 + A13,
    labeling([], Board),
    write(Board).


% 1.b)
length_list(Size, Board):-
    length(Board, Size).

list_diag1([], []).
list_diag1([[E|_]|Ess], [E|Ds]) :-
    maplist(list_tail, Ess, Ess0),
    list_diag1(Ess0, Ds).

list_tail([_|Es], Es).

list_diag2(Ess,Ds) :-
    maplist(reverse, Ess, Fss),
    list_diag1(Fss, Ds).

domain_list(N1, N2, List):-
    domain(List, N1, N2).

sum_list(Sum, Operador, List):-
    sum(List, Operador, Sum).

flatten([], []).
flatten([H | T], FlattedBoard):-
    flatten(T, NewFlatten),
    append(H, NewFlatten, FlattedBoard).

quadrado_NxN(Board, N):-
    length(Board, N),
    maplist(length_list(N), Board),
    flatten(Board, FlattedBoard),
    all_distinct(FlattedBoard),
    Ntimes is N * N,
    maplist(domain_list(1, Ntimes), Board),
    Sum is (Ntimes + 1) * N // 2,
    maplist(sum_list(Sum, #=), Board),
    transpose(Board, NewBoard),
    maplist(sum_list(Sum, #=), NewBoard),
    list_diag1(Board, Diag1),
    sum_list(Sum, #=, Diag1),
    list_diag2(Board, Diag2),
    sum_list(Sum, #=, Diag2),
    maplist(labeling([]), Board).