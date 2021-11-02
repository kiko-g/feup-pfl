% Factor can be sqrt(N) tops
% 3 is the first number that is eligible to be a factor
isPrime(1).
isPrime(2).
isPrime(N):-
    integer(N),
    N > 3,
    N mod 2 =\= 0, 
    \+hasFactor(N,3). 

hasFactor(N, Factor) :- 
    N mod Factor =:= 0.

hasFactor(N, Factor) :- 
    Factor * Factor < N,
    NextFactor is Factor + 2, 
    hasFactor(N, NextFactor). 
