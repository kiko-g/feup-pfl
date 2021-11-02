clear:- write('\33\[2J').
:- dynamic played/4.
% :- use_module(library(lists)).
%player(Name, Username, Age)
player('Manny', 'The Player', 14).
player('Johnny', 'A Player', 16).
player('Annie', 'Worst Player Ever', 24).
player('Danny', 'Best Player Ever', 27).
player('Harry', 'A-Star Player', 26).
%game(Name, Categories, MinAge)
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).
%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).
played('Worst Player Ever', '5 ATG', 52, 9).


% 1.
% Player completou pelo menos 80% de um jogo
achievedALot(Player):-
   played(Player, _, _, PercentUnlocked),
   PercentUnlocked >= 80.
% 2.
% Game e um jogo adequado a idade de Name
isAgeAppropriate(Name, Game):-
    player(Name, _, Age),
    game(Game, _, MinAge),
    Age >= MinAge.
% 3.
% Num de horas que Player investiu a jogar cada um de Games
% when games is empty pass "return" L and S to ListTimes and Sum
time_aux(_, [], L, S, L, S). 
time_aux(User, [Head | Tail], Buffer, Sum, LN, SN):-
    played(User, Head, Hours, _),
    S is Sum + Hours,
    append(Buffer, [Hours], L),
    time_aux(User, Tail, L, S, LN, SN).

timePlayingGames(User, Games, ListTimes, Sum):-
    time_aux(User, Games, [], 0, ListTimes, Sum).
% 4.
% Imprime na consola os jogos da categoria C e MinAge
listGamesOfCategory(C):-
    findall(Game, (game(Game, Categories, MinAge), member(C, Categories)), GameList),
    findall(MinAge, (game(Game, Categories, MinAge), member(C, Categories)), AgeList),
    printList2(GameList, AgeList).

printList2([], []).
printList2([H1 | T1], [H2 | T2]):-
    write(H1), write(' ('), write(H2), write(')'), nl,
    printList2(T1, T2).
% 5.
% Atualiza base de conhecimento relativamente ao n de horas que Player jogou Game
updatePlayer(Player, Game, Hours, Percentage):-
    retract(played(Player, Game, H, P)),
    NewHours is Hours + H,
    NewPercent is Percentage + P,
    assert(played(Player, Game, NewHours, NewPercent)).
% 6.
% Devolve lista de jogos nos quais Player investiu menos de 10h a jogar
fewHours(Player, Games):-
    fewHoursAux(Player, [], Games).

fewHoursAux(_, FinalGames, FinalGames).
fewHoursAux(Player, Buffer, FinalGames):-
    played(Player, Game, Hours, _),
    Hours < 10,
    (\+member(Game, Buffer)), !,
    fewHoursAux(Player, [Game | Buffer], FinalGames).


%
littleAchievment(Player, Games):-
    littleAux(Player, [], Games).

littleAux(Player, Buffer, Games):-
    played(Player, Game, _, P),
    P<20,
    \+member(Game, Buffer),!,
    littleAux(Player, [Game | Buffer], Games).
littleAux(_, Buffer, Buffer).



% 7.
% Devolve lista dos jogadores com idade compreendida entre MinAge e MaxAge (limites inclusivos)
ageRange(MinAge, MaxAge, Players):-
    findall(PlayerName, (player(PlayerName, _, Age), Age>=MinAge, Age=<MaxAge), Players).

% 8.
% Idade media dos jogadores que jogam o jogo 'Game'
averageAge(Game, AverageAge):-
    findall(Age, (played(Username, Game, _, _), player(_, Username, Age)), AgeList),
    sumList(AgeList, 0, AgeSum),
    length(AgeList, Size),
    AverageAge is AgeSum/Size.

sumList([], C, C).
sumList([Head | Tail], S, NS):-
    Aux is S+Head,
    sumList(Tail, Aux, NS).

% determina o(s) jogador(es) que jogam o jogo Game com
% maior eficiencia (maior percentagem em menos horas)
mostEffectivePlayers(Game, Players) :-
    findall(EF, (played(_, Game, Hours, Perc), EF is Perc/Hours), EFList), !,
    write(EFList),nl,nl,
    getBestValue(EFList, BestValue), !,
    findall(Player, (played(Player, Game, Hours, Perc), EF is Perc/Hours, EF = BestValue), Players).

getBestValue([LastElement|[]], LastElement).
getBestValue([FirstElement|OtherElements], BestValue) :-
    getBestValue(OtherElements, NewValue),
    (
        FirstElement > NewValue,
        BestValue is FirstElement;
        BestValue is NewValue
    ).



%10
whatDoesItDo(User):-
    player(_, User, Age),!,
    \+ (played(User, Game, _, _),
        game(Game, _, MinAge),
        MinAge > Age).

/* 
É sugerida a mudança do predicado whatDoesItDo para o predicado acima:
Este predicado verifica se o jogador com o UserName dado,
jogou algum jogo para o qual tem idade mínima
*/

%11
/*
Uma boa representação para armazenar esta informação é uma lista 
de listas, na qual cada linha contém mais 1 elemento que a anterior,
uma vez que a matrix é simétrica. Também é ignorada a primeira linha,
pois a matriz tem apenas 0's na diagonal.
Representação da matriz dada:
L = [[8], [8, 2], [7, 4, 3], [7, 4, 3, 1]]
*/

%12
areFar(Dist, Matriz, List) :-
    Line = 2,
    areFar_helper(Dist, Matriz, Line, List).

areFar_helper(_, [], _, []) :- !.
areFar_helper(Dist, [FirstLine|OtherLines], Line, List) :-
    NextLine is Line + 1, !,
    areFar_helper(Dist, OtherLines, NextLine, NewLineList),
    Column = 1, !,
    areFar_line_helper(Dist, FirstLine, Line, Column, LineList),
    append(LineList, NewLineList, List), !.

areFar_line_helper(_, [], _, _, []) :- !.
areFar_line_helper(Dist, [FirstElem|OtherElems], Line, Column, LineList) :-
    NextColumn is Column + 1,
    areFar_line_helper(Dist, OtherElems, Line, NextColumn, NewList),
    (
        FirstElem >= Dist,
        append([Line/Column], NewList, LineList);
        LineList = NewList
    ), !.

%13
/*
Estrutura proposta: lista com 1 inteiro, e dois elementos que podem 
ser de dois tipos (lista ou átomo (quando é folha)). Assim, ficam 
representados os 3 elementos necessários em cada nó: o id, o filho da 
esquerda e o filho da direita
L = [0, [ 1, [ 2, [ 3, [ 4, australia, [ 5, [6, staHelena, anguila],
    georgiaDoSul]], reinoUnido], [7, servia, franca]], [8, 
    [9, niger, india], irlanda]], brasil]
*/

%14
distance(C1, C2, Dendogram, Dist) :-
    D = 0,
    getDistance(C1, Dendogram, D, D1),
    getDistance(C2, Dendogram, D, D2),
    Dist is 1 + abs(D1 - D2).

%Percorrer até encontrar átomo certo. Se encontrar átomo errado voltar atrás
getDistance(C, [_, Left, Right], Dist, FinalDist) :-
    NewDist is Dist + 1,
    call_getDistance(C, Left, NewDist, OtheDist),
    (
        nonvar(OtheDist),
        FinalDist = OtheDist;

        call_getDistance(C, Right, NewDist, FinalDist)
    ), !.

call_getDistance(C, C, Dist, Dist) :- !.

call_getDistance(C, L, Dist, FinalDist) :-
    is_list(L),
    getDistance(C, L, Dist, FinalDist), !.

call_getDistance(_, NL, _, _) :-
    \+is_list(NL), !.

