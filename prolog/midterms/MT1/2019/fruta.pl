% come(Pessoa, Fruta).
come(afonso, uva).
come(afonso, maca).
come(afonso, ananas).
come(afonso, melao).
come(bruno, banana).
come(bruno, melao).
come(carlos, uva).
come(carlos, melao).
come(carlos, ananas).
come(daniel, pera).
come(daniel, laranja).

% fruta(Fruta).
fruta(uva).
fruta(maca).
fruta(melao).
fruta(manga).
fruta(ananas).
fruta(banana).
fruta(cereja).
fruta(papaia).
fruta(damasco).
fruta(laranja).
fruta(melancia).

quemComeQueFrutos(Lista) :-
    findall(Fruta-Pessoas, (fruta(Fruta), findall(Pessoa, come(Pessoa, Fruta), Pessoas)), Lista).
