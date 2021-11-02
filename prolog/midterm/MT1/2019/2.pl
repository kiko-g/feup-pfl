tocou(ana, [bach, chopin]).
tocou(filipe, [lizst, beethoven]).
tocou(carlos, [chopin, mozart]).

ordem(1, filipe).
ordem(2, ana).
ordem(3, carlos).

instrumento(ana, piano).
instrumento(filipe, piano).
instrumento(carlos, piano).
instrumento(luis, clarinete).
instrumento(maria, violino).
instrumento(afonso, clarinete).
instrumento(eva, acordeao).

% 7
musicos_para_compositor(Compositor, ListaMusicos) :-
    findall(Musico, (tocou(Musico, Compositores), member(Compositor, Compositores)), ListaMusicos).

% 8
composParaInstrumentos(Compositor, ListaInstrumentos) :-
    findall(Musico, (tocou(Musico, Compositores), member(Compositor, Compositores)), Musicos),
    findall(Instrumento, (member(Musico, Musicos), instrumento(Musico, Instrumento)), ListaInstrumentosUnsorted),
    sort(ListaInstrumentosUnsorted, ListaInstrumentos).

% 9
musicosPorInstrumento(ListaMusicosPorInstrumento):-
    findall(I, instrumento(_, I), Is),
    sort(Is, Instrumentos),
    findall(
        Instrumento-Musicos,
        (member(Instrumento, Instrumentos), findall(Musico, instrumento(Musico, Instrumento), Musicos)),
        ListaMusicosPorInstrumentoUnsorted),
    sort(ListaMusicosPorInstrumentoUnsorted, ListaMusicosPorInstrumento).

% extra
ola(L) :-
    findall(Instrumento, instrumento(_, Instrumento), LUnsorted),
    sort(LUnsorted, L).

/* @@
- Setof, Bagof
- Mais recursividade
- Restricoes
*/
