clear:- 
  write('\e[H\e[2J').

tocou(ana, [bach, chopin]).
tocou(filipe, [lizst, beethoven]).
tocou(carlos, [chopin, mozart]).

ordem(1, filipe).
ordem(2, ana).
ordem(3, carlos).

% 1
antes(P1, P2):-
    ordem(Ordem1, P1),
    ordem(Ordem2, P2),
    Ordem1 < Ordem2.

% 2
comecou_com(Compositor):-
    ordem(1, P),
    tocou(P, Cs),
    primeiro_elemento(Cs, Compositor).

primeiro_elemento([Compositor | _], Compositor).

% 3
ausente(Compositor) :-
    \+ausente_aux(Compositor).

ausente_aux(Compositor):-
    tocou(_, Compositores),
    member(Compositor, Compositores).

% 4
um_pianista(Compositor) :-
    um_pianista_aux(Compositor, [], ListaPianistas),
    length(ListaPianistas, 1).

um_pianista_aux(Compositor, Pianistas, ListaFinal) :-
    tocou(Pianista, Compositores),
    \+member(Pianista, Pianistas),
    member(Compositor, Compositores), !,
    um_pianista_aux(Compositor, [Pianista|Pianistas], ListaFinal).
um_pianista_aux(_, ListaFinal, ListaFinal).

% 5
audicao:-
    audicao_aux(1).

audicao_aux(N) :-
    ordem(N, Pianista),
    tocou(Pianista, Compositores), !,
    format("~w:~w - ~w", [N, Pianista, Compositores]), nl,
    Next is N+1,
    audicao_aux(Next).
audicao_aux(_).
