:- include('db.pl').

/* predX(Age, IDs, Nomes).
 * Retorna na lista Nomes o nome de todas as atuacoes das pessoas
 * de idade inferior a Age, cujo id esta na lista IDs.
 *
 * O cut utilizado é verde, uma vez que não influencia o resultado do programa,
 * apenas a sua eficiência.
 */
predX(Q, [R|Rs], [P|Ps]) :-
    participant(R,I,P), I =< Q, !,
    predX(Q, Rs, Ps).
predX(Q, [R|Rs], Ps) :-
    participant(R,I,_), I > Q,
    predX(Q, Rs, Ps).
predX(_, [], []).
