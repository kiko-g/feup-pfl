clear:- 
  write('\e[H\e[2J').

not(X):-
  \+X.

write_all(X):-
    write(X), nl, fail.