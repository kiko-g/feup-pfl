% :- use_module(library(lists)).

%airport(Name, ICAO, Country).
airport('Aeroporto Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').
%company(ICAO, Name, Year, Country).
company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A.', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').
%flight(Designation, Origin, Destination, DepartureTime, Duration, Company).
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% 1. Short Flight
short(Flight):-
    flight(Flight, _, _, _, Time, _),
    Time < 90.

% 2. Shorter Flight
shorter(F1, F2, F1):- 
    flight(F1, _, _, _, T1, _),
    flight(F2, _, _, _, T2, _),
    T1 < T2.

shorter(F1, F2, F2):- 
    flight(F1, _, _, _, T1, _),
    flight(F2, _, _, _, T2, _),
    T2 < T1.

% 3. Arrival Time
arrivalTime(F1, Arrival):-
    flight(F1, _, _, StartTime, Duration, _),
    StartHours is StartTime // 100,
    StartMinutes is StartTime mod 100,
    TotalTime is StartHours*60 + StartMinutes+Duration,
    TotalTimeHours is (TotalTime // 60),
    TotalTimeMinutes is TotalTime - (TotalTimeHours*60),
    Arrival is (TotalTimeHours * 100) + TotalTimeMinutes.
    
% 4. Countries
countries(Company, ListOfCountries):-
    company(Company, _, _, _),
    findCountries(Company, ListOfCountries, []), !.

findCountries(Company, [Country | ListOfCountries], Seen) :-
    airport(_, _, Country),
    companyOperatesInCountry(Company, Country),
    \+member(Country, Seen), !,
    findCountries(Company, ListOfCountries, [Country | Seen]).
findCountries(_, [], _) :- !.

companyOperatesInCountry(Company, Country) :-
    flight(_, Origin, Dest, _, _, Company),
    airport(_, Origin, OriginCountry),
    airport(_, Dest, DestCountry),
    (
        OriginCountry = Country;
        DestCountry = Country
    ), !.

% 5. 
pairableFlights :-  
    is_pairable(F1, F2, Dest),
    write(Dest), write(' - '), write(F1), write(' \\ '), write(F2), nl,
    fail.
pairableFlights :- !.

is_pairable(F1, F2, Dest) :-
    flight(F1, _, Dest, _, _, _), 
    flight(F2, Dest, _, T2, _, _),
    arrivalTime(F1, T1), 
    Diff is ((T2 mod 100) + 60*(T2//100)) - ((T1 mod 100) + 60*(T1//100)),
    Diff >= 30,
    Diff =< 90.

sumList([], 0).
sumList([H|T], Result):-
    sumList(T, Total),
    Result is Total + H.