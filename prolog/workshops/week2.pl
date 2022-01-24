% 1. Recursion
% a) Fatorial
fatorial(0, 1).
fatorial(N, F) :-
    N>0,
    N1 is N-1,
    fatorial(N1, F1),
    F is N*F1.


% a) Fatorial Alternate
fatorialAltAux(1, F, F).
fatorialAltAux(N, F, NewF) :-
    NextN is N-1,
    NextF is N*F,
    fatorialAltAux(NextN, NextF, NewF).

fatorialAlt(N, F) :-
    N>0,
    fatorialAltAux(N, 1, F).

% b) Sum N
somaRec(0, 0).
somaRec(N, Sum) :-
    N>0,
    N1 is N-1,
    somaRec(N1, Sum1),
    Sum is Sum1+N.

% b) Sum N Alternate
somaRecAltAux(0, Sum, Sum).
somaRecAltAux(N, Sum, SumReturn) :-
    NextN is N-1,
    NextSum is N+Sum,
    somaRecAltAux(NextN, NextSum, SumReturn).

somaRecAlt(N, Sum) :-
    somaRecAltAux(N, 0, Sum).

% c) Fibonacci
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, Fib) :-
    N>1,
    N1 is N-1,
    N2 is N-2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    Fib is F1+F2.

% d) Is Prime
isPrimeAux(X, N):- N>1, X rem N =:= 0.
isPrimeAux(X, N):- N>1, Next is N-1, isPrimeAux(X, Next).

isPrime(1).
isPrime(X) :-
    N is X-1,
    \+ isPrimeAux(X, N).

% 2. Family relationships
female(grace).
female(haley).
female(dede).
female(gloria).
female(barb).
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
male(merle).
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

% a) ancestor
ancestor(X, Y):-
    parent(X, Y).

ancestor(X, Y):-
    parent(X, Z), ancestor(Z, Y).

% b) descendant
descendant(X, Y):-
    parent(Y, X).

descendant(X, Y):-
    parent(Y, Z), descendant(X, Z).

% 3.
cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

superior(X, Y):-
    cargo(Cx, X),
    cargo(Cy, Y),
    chefiado_por(Cy, Cx).

superior(X, Y):-
    cargo(Cx, X),
    cargo(_, Y),
    cargo(Cz, Z),
    chefiado_por(Cz, Cx), superior(Z, Y).

% 4.
% a) true
% b) false
% c) true
% d) H = pfl, T = [lbaw, redes, ltw]
% e) H = lbaw, T = [ltw]
% f) H = leic, T = []
% g) false
% h) H = leic, T = [[pfl, ltw, lbaw, redes]]
% i) H = leic, T = [Two]
% j) Inst = gram, LEIC = feup
% k) One = 1, Two = 2, Tail = [3, 4]
% l) One = leic, Rest = [Two|Tail]

% 5
% a) list size
list_size(List, Size):-
    list_size_aux(List, 0, Size).

list_size_aux([], Size, Size).
list_size_aux([_ | T], CurrentSize, Size):-
    NewSize is CurrentSize + 1,
    list_size_aux(T, NewSize , Size).

% b) list sum
list_sum(List, Sum):-
    list_sum_aux(List, 0, Sum).

list_sum_aux([], Sum, Sum).
list_sum_aux([H | T], CurrentSum, Sum):-
    NewSum is CurrentSum + H,
    list_sum_aux(T, NewSum, Sum).

% c) list product
list_prod(List, Prod):-
    list_prod_aux(List, 1, Prod).

list_prod_aux([], Prod, Prod).
list_prod_aux([H | T], CurrentProd, Prod):-
    NewProd is CurrentProd * H,
    list_prod_aux(T, NewProd, Prod).

% d) inner product
inner_product(List1, List2, Result):-
    inner_product_aux(List1, List2, 0, Result).

inner_product_aux([], [], Result, Result).
inner_product_aux([A | Rest1], [B | Rest2], CurrentResult, Result):-
    NewResult is CurrentResult + A * B,
    inner_product_aux(Rest1, Rest2, NewResult, Result).

% e) count occurences 
count(Elem, List, N):-
    count_aux(Elem, List, 0, N).

count_aux(_, [], Count, Count).
count_aux(Elem, [H | T], CurrentCount, Count):-
    Elem = H, NextCount is CurrentCount + 1,
    count_aux(Elem, T, NextCount, Count).

count_aux(Elem, [H | T], CurrentCount, Count):-
    Elem \= H, count_aux(Elem, T, CurrentCount, Count).

% 6. 
% a) invert list
invert(List1, List2):-
    invert_aux(List1, [], List2).

invert_aux([], Result, Result).
invert_aux([H | T], Inverse, Result):-
    invert_aux(T, [H | Inverse], Result).


% b) delete one element
del_one(Elem, [H | T], List):-
    Elem = H,
    del_one_aux(Elem, [], T, List).

del_one(Elem, [H | T], List):-
    Elem \= H,
    del_one(Elem, T, List).
