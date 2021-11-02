% D:\PLOG\Studio\PL\A3_Lists

% 3. Append
append_list([], L, L).
append_list([E|L1], L2, [E|L3]) :- append_list(L1, L2, L3).


% 4. reverse_list
reverse_list(L, LR):-
    reverse_aux(L, [], LR).

reverse_aux([], LR, LR). % When L is empty copy SubList to LR
reverse_aux([H|T], SubList, LR):-
    reverse_aux(T, [H|SubList], LR).


% 5. member
% a)
member_list(E, [E|_]).
member_list(E, [_|T]) :- member_list(E, T).

% b) 
first_member(E, L):- append_list([], [E|_], L).

% c) 
last_member(E, L):- append_list(_, [E], L).

% d) Index, List, Element
nth_member(1, [E|_], E).
nth_member(I, [_|T], E):- 
    I > 1,
    NewIndex is I-1,
    nth_member(NewIndex, T, E).


% 6. delete
% a)
delete_one(E, L1, L2):-
    append_list(La, [E|Lb], L1),
    append(La, Lb, L2).

% b)
delete_all(_, [], []).

delete_all(E, [E|Xs], Y) :- % caught an element, append only to one list
    delete_all(E, Xs, Y).

delete_all(E, [T|Xs], [T|Y]) :- % append to beiginning of both lists
    E \= T,
    delete_all(E, Xs, Y).
