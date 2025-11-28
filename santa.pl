:- use_module('secret').

% Change these to reflect people in your gift-giving group, 
% and any pairs you want to disallow (eg, partners)
family(['Mike', 'Carol', 'Marsha', 'Jan', 'Cindy', 'Greg', 'Peter', 'Bobby', 'Alice', 'Sam']).
partners('Mike', 'Carol').
partners('Alice', 'Sam').

is_partner(X, Y) :- partners(X, Y).
is_partner(X, Y) :- partners(Y, X).

solve_santa([], _, []).

solve_santa([Giver|RestGivers], Receivers, [[Giver,Receiver]|RestPairs]) :-
    select(Receiver, Receivers, RestReceivers),
    Giver \== Receiver,             % Not themselves
    \+ is_partner(Giver, Receiver), % Not their partner
    solve_santa(RestGivers, RestReceivers, RestPairs).

find_santas(SecretSantas) :-
    family(People),
    get_time(Now),
    Seed is floor(Now * 1000),
    set_random(seed(Seed)),
    random_permutation(People, ShuffledReceivers),
    solve_santa(People, ShuffledReceivers, Pairs),
    !,
    maplist(gen_url, Pairs, SecretSantas).

find_and_print :-
    find_santas(Santas),
    print_santas(Santas).

print_santas(Santas) :-
    format('~w~t~20| ~w~n', ['Giver', 'URL']),
    format('~`-t~20| ~`-t~80|~n', []),
    forall(
        member([Giver, Url], Santas),
        format('~w~t~20| ~w~n', [Giver, Url])
    ).




