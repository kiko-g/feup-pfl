/*

traduza(Codigo, Significado) :-
    Codigo = 1,
    Significado = integer_overflow.

traduza(Codigo, Significado) :-
    Codigo = 2,
    Significado = divisao_por_zero.

traduza(Codigo, Significado) :-
    Codigo = 3,
    Significado = id_desconhecido. 

*/

erro(1, integer_overflow).
erro(2, divisao_por_zero).
erro(3, id_desconhecido).

traduza(Codigo, Significado) :-
    erro(Codigo, Significado).