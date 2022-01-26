% General auxiliar predicates
myappend([], L2, L2).
myappend([H|T], L2, [H|T3]) :-
    myappend(T, L2, T3).

last([X], X).
last([_|Xs], X) :-
    last(Xs, X).

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
isPrimeAux(X, N) :-
    N>1,
    X rem N=:=0.
isPrimeAux(X, N) :-
    N>1,
    Next is N-1,
    isPrimeAux(X, Next).

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
ancestor(X, Y) :-
    parent(X, Y).

ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

% b) descendant
descendant(X, Y) :-
    parent(Y, X).

descendant(X, Y) :-
    parent(Y, Z),
    descendant(X, Z).

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

superior(X, Y) :-
    cargo(Cx, X),
    cargo(Cy, Y),
    chefiado_por(Cy, Cx).

superior(X, Y) :-
    cargo(Cx, X),
    cargo(_, Y),
    cargo(Cz, Z),
    chefiado_por(Cz, Cx),
    superior(Z, Y).

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
list_size(List, Size) :-
    list_size(List, 0, Size).

list_size([], Size, Size).
list_size([_|T], Acc, Size) :-
    NextAcc is Acc+1,
    list_size(T, NextAcc, Size).

list_size_alt([], 0).
list_size_alt([_|T], L) :-
    list_size_alt(T, L1),
    L is L1+1.

% b) list sum
list_sum(List, Sum) :-
    list_sum(List, Sum, 0).

list_sum([], Sum, Sum).
list_sum([H|T], Sum, CurrentSum) :-
    NewSum is CurrentSum+H,
    list_sum(T, Sum, NewSum).

% c) list product
list_prod(List, Prod) :-
    list_prod(List, 1, Prod).

list_prod([], Prod, Prod).
list_prod([H|T], Acc, Prod) :-
    NextAcc is Acc*H,
    list_prod(T, NextAcc, Prod).

% d) inner product
inner_product(List1, List2, Result) :-
    inner_product_aux(List1, List2, 0, Result).

inner_product_aux([], [], Result, Result).
inner_product_aux([A|Rest1], [B|Rest2], CurrentResult, Result) :-
    NewResult is CurrentResult+A*B,
    inner_product_aux(Rest1, Rest2, NewResult, Result).

% e) count occurences 
count(Elem, List, N) :-
    count_aux(Elem, List, 0, N).

count_aux(_, [], Count, Count).
count_aux(Elem, [H|T], CurrentCount, Count) :-
    Elem=H,
    NextCount is CurrentCount+1,
    count_aux(Elem, T, NextCount, Count).

count_aux(Elem, [H|T], CurrentCount, Count) :-
    Elem\=H,
    count_aux(Elem, T, CurrentCount, Count).

% 6. 
% a) invert list
invert(List1, List2) :-
    invert_aux(List1, [], List2).

invert_aux([], Result, Result).
invert_aux([H|T], Inverse, Result) :-
    invert_aux(T, [H|Inverse], Result).


% b) delete one occurence of element
del_one(_, [], []).
del_one(E, [E|T], T).
del_one(E, [H|T], [H|T1]) :-
    E\=H,
    del_one(E, T, T1).

% c) delete all occurences of element
del_all(_, [], []).
del_all(E, [E|T], R) :-
    del_all(E, T, R).
del_all(E, [H|T], [H|T1]) :-
    E\=H,
    del_all(E, T, T1).

% d) delete all occurences of all elements provided
del_all_list([], [], []).
del_all_list([], R, R).
del_all_list([E|Es], L, R1) :-
    del_all(E, L, R),
    del_all_list(Es, R, R1).

% e) delete duplicates
del_dups([], []).
del_dups(List, Result) :-
    del_dups(List, [], Result).

del_dups([], Result, Result).
del_dups([X|Xs], Distinct, Result) :-
    (   member(X, Distinct),
        del_dups(Xs, Distinct, Result)
    ;   \+ member(X, Distinct),
        del_dups(Xs, [X|Distinct], Result)
    ).

% f) determine if list is a permutation of another list
list_perm([], []).
list_perm([X|Xs], [Y|Ys]) :-
    length([X|Xs], S1),
    length([Y|Ys], S2),
    S1=:=S2,
    list_perm_aux([X|Xs], [Y|Ys]).

list_perm_aux([], _).
list_perm_aux([X|Xs], Ys) :-
    member(X, Ys),
    list_perm_aux(Xs, Ys).

% g) create a list with Amount Elems
replicate(Amount, Elem, List) :-
    replicate(Amount, Elem, [], List).

replicate(0, _, List, List).
replicate(Amount, Elem, ListAcc, List) :-
    NextAmount is Amount-1,
    replicate(NextAmount, Elem, [Elem|ListAcc], List).

% h) L2 will become L1 with Elem values in between its elements
intersperse(Elem, L1, L2) :-
    intersperse(Elem, L1, [], L2R),
    invert(L2R, L2).

intersperse(_, [X], L, [X|L]).
intersperse(Elem, [X|Xs], ListAcc, R) :-
    intersperse(Elem, Xs, [Elem, X|ListAcc], R).

% i) insert_elem(+Index, +L1, +Elem, ?L2)
insert_elem(0, L1, Elem, [Elem|L1]).
insert_elem(Index, L1, Elem, L2) :-
    length(L1, S1),
    Index=<S1,
    insert_elem(Index, L1, [], Elem, L2).

insert_elem(Index, [X|XRight], XLeft, Elem, L2) :-
    Index\=0,
    NextIndex is Index-1,
    insert_elem(NextIndex, XRight, [X|XLeft], Elem, L2).

insert_elem(0, XRight, XLeftReversed, Elem, L2) :-
    invert(XLeftReversed, XLeft),
    myappend(XLeft, [Elem], XLeftElem),
    myappend(XLeftElem, XRight, L2).

% j) delete_elem(+Index, +List1, ?Elem, ?List2)
delete_elem(0, [Elem|L1], Elem, L1).
delete_elem(_, L1, Elem, L1) :-
    \+ member(Elem, L1).

delete_elem(Index, L1, Elem, L2) :-
    length(L1, S1),
    Index=<S1,
    delete_elem(Index, L1, [], Elem, L2).

delete_elem(Index, [X|XRight], XLeft, Elem, L2) :-
    Index\= -1,
    NextIndex is Index-1,
    delete_elem(NextIndex, XRight, [X|XLeft], Elem, L2).

delete_elem(-1, XRight, [X|XLeftReversed], Elem, L2) :-
    X=Elem,
    invert(XLeftReversed, XLeft),
    myappend(XLeft, XRight, L2).

% k)
replace(0, [Old|L1], Old, New, [New|L1]).
replace(_, L1, Old, _, L1) :-
    member(Old, L1).

replace(Index, L1, Old, New, L2) :-
    length(L1, S1),
    Index=<S1,
    replace(Index, L1, [], Old, New, L2).

replace(Index, [X|XRight], XLeft, Old, New, L2) :-
    Index \= -1,
    NextIndex is Index-1,
    replace(NextIndex, XRight, [X|XLeft], Old, New, L2).

replace(-1, XRight, [X|XLeftReversed], Old, New, L2) :-
    write(X),
    X=Old,
    invert(XLeftReversed, XLeft),
    write(XLeft),
    write(XRight),
    myappend(XLeft, [New], XLeftElem),
    myappend(XLeftElem, XRight, L2).
