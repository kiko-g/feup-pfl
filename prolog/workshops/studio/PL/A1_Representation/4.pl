pessoa(ana).
pessoa(antonio).
pessoa(barbara).
pessoa(bruno).

comida(peru).
comida(frango).
comida(salmao).
comida(solha).

bebida('Cerveja').
bebida('Vinho Maduro').
bebida('Vinho Verde').

gosta(ana, 'Vinho Verde').
gosta(bruno, 'Vinho Verde').
gosta(antonio, 'Cerveja').

casados(ana, bruno).

combina(peru, 'Cerveja').
combina(solha, 'Cerveja').
combina(frango, 'Vinho Verde').
combina(salmao, 'Vinho Maduro').



a(Pessoa1, Pessoa2, Coisa):-
  casados(Pessoa1, Pessoa2),
  gosta(Pessoa1, Coisa),
  gosta(Pessoa2, Coisa).

b(Bebida):-
  bebida(Bebida),
  combina(salmao, Bebida).

c(Comida):-
  comida(Comida),
  combina(Comida, 'Vinho Verde').