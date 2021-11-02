:- use_module(library(clpfd)).
:- use_module(library(lists)).

% utils
clear:- write('\e[H\e[2J').
not(X):- \+X.
write_all(X):- write(X), nl, fail.

% -------------------------------------------------------------------------- % 
% -------------------------------------------------------------------------- % 

e1(A, B, C):-
    A in 1..7,
    domain([B, C], 1, 10),
    A + B + C #= A * B * C,
    A #> B,
    labeling([], [A, B, C]),
    write_all([A, B, C]). % write all solutions

% mm([S,E,N,D,M,O,R,Y], Type) :-
%     domain([S,E,N,D,M,O,R,Y], 0, 9), % step 1
%     S#>0, M#>0,
%     all_different([S,E,N,D,M,O,R,Y]), % step 2
%     sum(S,E,N,D,M,O,R,Y),
%     labeling(Type, [S,E,N,D,M,O,R,Y]). % step 3

% sum(S, E, N, D, M, O, R, Y) :-
%     1000*S + 100*E + 10*N + D + 1000*M + 100*O + 10*R + E #= 10000*M + 1000*O + 100*N + 10*E + Y.



% -------------------------------------------------------------------------- % 
% -------------------------------------------------------------------------- % 

programa(L):-
    length(L, 10),
    domain(L, 1, 20),
    labeling([], L),
    sumlist(L, 110),
    check(L).

check([]).
check([H|T]):- diff(H, T), check(T).

diff(_, []).
diff(E, [H|T]):- E \= H, diff(E, T).

% 3
melhor(L):-
    length(L, 10),
    domain(L, 1, 20),
    all_distinct(L),
    sum(L, #=, 110),
    labeling([], L).

% 4
equilibrado(L):-
    length(L, 10),
    domain(L, 1, 20),
    sum(L, #=, 110),
    all_distinct(L),
    minimum(Min, L),
    maximum(Max, L),
    Diff #= Max - Min,
    labeling([minimize(Diff)], L).

% 5
tresQuadrados(A, B, C):-
    domain([A, B, C], 1, 1000),
    X #> 0, Y #> 0, Z #> 0, W #> 0,
    A #< B, B #< C,
    A+B+C #= X * X,
    A*B+C #= Y * Y,
    A*C+B #= Z * Z,
    B*C+A #= W * W,
    labeling([], [A, B, C]),
    write_all([A, B, C]).

% crescente([]).
% crescente([_]).
% crescente([A,B|T]):-
%     A #=< B,
%     append([B], T, Next),
%     crescente(Next).

% Extra
restricao_produto([], _, 1).
restricao_produto([Pos|Ps], Nums, Prod):- 
    nth1(Pos, Nums, Num), 
    Prod #= Prod1 * Num, 
    restricao_produto(Ps, Nums, Prod1). 

restricao_pares([], _, _).
restricao_pares(Posicoes, Nums, NPares):-
    conta_pares(Posicoes, Nums, NPares, 0).

conta_pares(Posicoes, Nums, NPares, Count):-
    nth1(P, Nums, X),
    (
        X mod 2 == 1;
        Count = Count + 1
    ),
    conta_pares(Ps, Nums, NPares, Count),
    Count #= NPares.

restricao_remover_simetrias([]).
restricao_remover_simetrias([_]).
restricao_remover_simetrias([P1,P2|Ps]):-
    nth1(P1, Nums, N1),
    nth1(P2, Nums, N2),
    N1 #=< N2,
    append([P2], Ps, Next),
    restricao_remover_simetrias(Next).


fatores(Nums, Prod, NPosicoes, NPares, Posicoes):-
    length(Posicoes, NPosicoes), 
    all_distinct(Posicoes),

    restricao_produto(Posicoes, Nums, Prod),
    restricao_pares(Posicoes, Nums, NPares),
    restricao_remover_simetrias(Posicoes),
    
    labeling([], Posicoes).
