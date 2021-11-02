:- use_module(library(lists)).

ligado(a,b).
ligado(f,i).
ligado(a,c).
ligado(f,j).
ligado(b,d).
ligado(f,k).
ligado(b,e).
ligado(g,l).
ligado(b,f).
ligado(g,m).
ligado(c,g).
ligado(k,n).
ligado(d,h).
ligado(l,o).
ligado(d,i).
ligado(i,f).

% a)
dfs(Start, End, Sol) :-
    dfs_step(Start, End, [], Inv),
    reverse(Inv, Sol).

dfs_step(Node, Node, Path, [Node | Path]).
dfs_step(Start, End, Path, Sol) :-
    ligado(Start, Node),
    \+member(Node, Path),
    dfs_step(Node, End, [Start | Path], Sol).


% b)

/*
bfs(Start, End, Sol) :-
    bfs_step([[Start]], End, Inv),
    reverse(Inv, Sol).

bfs_step([[End|T], _], End, [End,T]).
bfs_step([T|Fila], End, Sol) :-
    find_all(Path, extends())
*/
