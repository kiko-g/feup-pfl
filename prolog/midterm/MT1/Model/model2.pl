:- use_module(library(lists)).

% 6
nSuccessfulParticipants(T) :-
    findall(Peformer, performance(Peformer, [120, 120, 120, 120]), ResultList),
    length(ResultList, T).

% 7
juriFans(JuriFansList):-
    findall(P-Js, (performance(P, Ts), timesToFans(1, Ts, Js) ), JuriFansList).

timesToFans(_, [], []) :- !. % empty lists
timesToFans(Idx, [120|Times], [Idx|Fans]) :- !, % append becuase 120
    Idx1 is Idx+1,
    timesToFans(Idx1, Times, Fans).
timesToFans(Idx, [_|Times], Fans) :-  % append becuase 120
    Idx1 is Idx+1,
    timesToFans(Idx1, Times, Fans).

% 8
