jogo(1, sporting, porto, 1-2).
jogo(1, maritimo, benfica, 2-0).
jogo(2, sporting, benfica, 0-2).
jogo(2, porto, maritimo, 1-0).
jogo(3, maritimo, sporting, 1-1).
jogo(3, benfica, porto, 0-2).
treinadores(porto, [[1-3]-sergio_conceicao]).
treinadores(sporting, [[1-2]-silas, [3-3]-ruben_amorim]).
treinadores(benfica, [[1-3]-bruno_lage]).
treinadores(maritimo, [[1-3]-jose_gomes]).

% 1) n_treinadores(?Equipa, ?Numero)
n_treinadores(Equipa, Numero) :-
  treinadores(Equipa, Treinadores),
  length(Treinadores, Numero).

% 2) n_jornadas_treinador(?Treinador, ?NumeroJornadas)
get_jornadas_treinadores(Treinador, [Jornadas-Treinador|_], Jornadas).
get_jornadas_treinadores(Treinador, [_|Rest], Jornadas):-
  get_jornadas_treinadores(Treinador, Rest, Jornadas).

n_jornadas_treinador(Treinador, NumeroJornadas) :-
  treinadores(_, Treinadores),
  get_jornadas_treinadores(Treinador, Treinadores, [J0-JF]),
  NumeroJornadas is JF-J0+1.

% 3) ganhou(?Jornada, ?EquipaVencedora, ?EquipaDerrotada)
ganhou(Jornada, EquipaVencedora, EquipaDerrotada):-
  jogo(Jornada, EquipaVencedora, EquipaDerrotada, H-A),
  H > A.

ganhou(Jornada, EquipaVencedora, EquipaDerrotada):-
  jogo(Jornada, EquipaDerrotada, EquipaVencedora, H-A),
  H < A.

% 4) 
:- op(180, fx, o).

% 5) 
:- op(200, xfx, venceu).

% 6)
o X :- treinadores(X, _).
o X venceu o Y :- ganhou(_, X, Y).

% 7)
predX(N,N,_).
predX(N,A,B):-
  !,
  A \= B,
  A1 is A + sign(B - A),
  predX(N,A1,B).

/* 
a) O predicado tem permite saber se N está dentro do intervalo [A, B], caso N seja passado como input. 
Caso N seja valor de retorno, N inicialmente começa com o valor de A 
e vai aproximando-se do valor de B. A última resposta é N=B.
b) É um cut verde, já que não altera as soluções obtidas pelo predicado.
O cut presente poda a pesquisa de ramos que não levariam a uma solução, 
pelo que aumenta a eficiência do predicado.
*/

% 8) treinador_bom(?Treinador)
get_jornadas(Treinador, [Jornadas-Treinador|_], Jornadas).
get_jornadas(Treinador, [_|Rest], Jornadas) :-
  get_jornadas(Treinador, Rest, Jornadas).

treinador_bom(Treinador):-
  treinadores(Equipa, Treinadores),
  get_jornadas(Treinador, Treinadores, [Jornada0-JornadaF]), !,
  \+ (
    predX(Jornada, Jornada0, JornadaF),
    \+ ganhou(Jornada, Equipa, _)
  ).

% 9)
imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').
imprime_texto(X,'vitoria da casa'):- X = 1.
imprime_texto(X,'empate'):- X = 0.
imprime_texto(X,'derrota da casa'):- X = -1.

% obter_resultado(+GolosCasa, +GolosFora, -ResultadoNumero)
obter_resultado(GolosCasa, GolosFora, 1):- GolosCasa > GolosFora.
obter_resultado(GolosCasa, GolosFora, 0):- GolosCasa =:= GolosFora.
obter_resultado(GolosCasa, GolosFora, -1):- GolosCasa < GolosFora.

imprime_jogos(F):-
  jogo(Jornada, EquipaCasa, EquipaFora, GolosCasa-GolosFora),
  obter_resultado(GolosCasa, GolosFora, ResultadoNumero),
  format('Jornada ~d: ~s x ~s - ', [Jornada, EquipaCasa, EquipaFora]),
  X =.. [F, ResultadoNumero, ResultadoString],
  X, write(ResultadoString), nl, fail.
imprime_jogos(_).

% 10) Os predicados imprime_totobola/2 e imprime_texto/2 são igualmente eficientes, pois efetuam a mesma quantidade de unificações quando executados.

% 11) Apenas shutdown/0 e imprime_jogos/1 são extra-lógicos.

% 12) lista_treinadores(?L)
lista_treinadores(L):-
  findall(Treinador, (
      treinadores(_, Treinadores),
      get_jornadas_treinadores(Treinador, Treinadores, _)
    ), L).

% 13) duracao_treinadores(?L)
duracao_treinadores(L):-
  findall(Jornadas-Treinador, (
      n_jornadas_treinador(Treinador, Jornadas)
    ), L1),
  sort(0, @>=, L1, L).
