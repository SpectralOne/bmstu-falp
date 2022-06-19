:- use_module(library(clpfd)).

character(adam, 1000).
character(eric, 999).

damage(adam, eric, 100).
damage(eric, adam, 300).

alive(N) :- N > 0.
dead(N) :- \+ alive(N).

battle(N1, N2, Desired) :-
    character(N1, H1), character(N2, H2),
    damage(N1, N2, D1), damage(N2, N1, D2),
    round(0, H1, H2, D1, D2, RH1, RH2, Total),
    alive(RH1), Total #=< Desired.

round(N, H1, H2, D1, D2, RH1, RH2, ResultN) :-
    ( dead(H1);dead(H2) -> ResultN = N, RH1 = H1, RH2 = H2
    ;
        NH1 is H1 - D2,
	NH2 is H2 - D1,
	N1 is N + 1,
	round(N1, NH1, NH2, D1, D2, RH1, RH2, ResultN)
).

