% backtracking 1
r(a,b).
r(a,c).
r(b,a).
r(a,d).
s(b,c).
s(b,d).
s(c,c).
s(d,e).

z(X, Y, Z):-
    r(X,Y), s(Y,Z), not(r(Y,X)), not(s(Y,Y)).

% r(X,Y), s(Y,Z), not(r(Y,X)), not(s(Y,Y)).
% answer: (X,Y,Z) = (a,d,e)
