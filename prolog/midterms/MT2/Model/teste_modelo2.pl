:- use_module(library(lists)).
:- use_module(library(clpfd)).

% utils
clear:- write('\e[H\e[2J').
not(X):- \+X.
write_all(X):- write(X), nl, fail.

% 1
p1(L1,L2) :-
    gen(L1,L2),
    test(L2).

gen([],[]).
gen(L1,[X|L2]) :-
    select(X,L1,L3),
    gen(L3,L2).

test([]).
test([_]).
test([_,_]).
test([X1,X2,X3|Xs]) :-
    (X1 < X2, X2 < X3; X1 > X2, X2 > X3),
    test(Xs).


% 2
p2(L1,L2) :-
    length(L1,N),
    length(L2,N),
    pos(L1,L2,Is),
    all_distinct(Is),
    test(L2).

pos([],_,[]).
pos([X|Xs],L2,[I|Is]) :-
    nth1(I,L2,X),
    pos(Xs,L2,Is).
% Resposta: As variáveis de domínio estão a ser instanciadas antes da fase de pesquisa
 

% 3
p3(L1, L2) :-
    length(L1, N),
    length(L2, N),

    all_distinct(L2),
    list_to_fdset(L1, L1_Set),
    force_members(L2, L1_Set),

    test_plr(L2),
    labeling([], L2).

force_members([], _).
force_members([Curr|Rest], Set) :-
    Curr in_set Set,
    force_members(Rest, Set).

test_plr([]).
test_plr([_]).
test_plr([_,_]).
test_plr([X1,X2,X3|Xs]) :-
    (X1 #< X2 #/\ X2 #< X3) #\/
    (X1 #> X2 #/\ X2 #> X3),
    test_plr(Xs).


% 4
sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs):-
	length(Cookings, 3),
	length(RecipeTimes, NumberOfRecipes),
	domain(Cookings, 1, NumberOfRecipes),
	all_distinct(Cookings),

	get_eggs(Cookings, RecipeEggs, Eggs),
	get_time(Cookings, RecipeTimes, Time),

	Eggs #< NEggs,
	Time #< MaxTime,
	append([Cookings, [Eggs]], FinalCombination),
	labeling([maximize(Eggs)], FinalCombination).

get_eggs([], _, 0).
get_eggs([Index|Cookings], RecipeEggs, TotalEggs):-
	element(Index, RecipeEggs, Eggs),
	TotalEggs #= Eggs + NewEggs,
	get_eggs(Cookings, RecipeEggs, NewEggs).

get_time([], _, 0). 
get_time([Index|Cookings], RecipeTimes, TotalTime):-
	element(Index, RecipeTimes, Time), 
	TotalTime #= Time + NewTime, 
	get_time(Cookings, RecipeTimes, NewTime).


% 5
embrulha(Rolos, Presentes, RolosSelecionados):-
	length(Rolos, NumRolos), 
	length(Presentes, NumPresentes),
	length(RolosSelecionados, NumPresentes), 
	domain(RolosSelecionados, 1, NumRolos),
	
	generate_tasks(Tasks, RolosSelecionados, Presentes), 
	generate_machines(Machines, 1, Rolos), 
	cumulatives(Tasks, Machines, [bound(upper)]),
	labeling([], RolosSelecionados).

generate_tasks([], [], []). 
generate_tasks([task(1,1,2,Size,Index)|Tasks], [Index|RolosSelecionados], [Size|Presentes]):-
	generate_tasks(Tasks, RolosSelecionados, Presentes).

generate_machines([], _, []).
generate_machines([machine(Index, Size)|Machines], Index, [Size|Rolos]):-
	NewIndex is Index + 1, 
	generate_machines(Machines, NewIndex, Rolos).