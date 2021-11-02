:- include('p10.pl').


impoeLista(0, _) :- !.
impoeLista(N, L) :-
    impoe(N, L),
    Next is N-1,
    impoeLista(Next, L).    
        
langford(N, L) :-
    Size is N*2,
    length(L, Size),
    impoeLista(N, L).