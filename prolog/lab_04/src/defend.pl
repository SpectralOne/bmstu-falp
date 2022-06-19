:- use_module(library(clpfd)).

node([X], node(X)).
node(Nodes, X + Y) :-
    append([L|Left], [R|Right], Nodes),
    node([L|Left], X),
    node([R|Right], Y).
node(Nodes, X * Y) :-
    append([L|Left], [R|Right], Nodes),
    node([L|Left], X),
    node([R|Right], Y).
node(Nodes, X - Y) :-
    append([L|Left], [R|Right], Nodes),
    node([L|Left], X),
    node([R|Right], Y).
%node(Nodes, X // Y) :-
%    append([L|Left], [R|Right], Nodes),
%    node([L|Left], X),
%    node([R|Right], Y).

bracketize(node(X)) --> [X].
bracketize(X + Y) --> ['('], bracketize(X), [+], bracketize(Y), [')'].
bracketize(X * Y) --> ['('], bracketize(X), [*], bracketize(Y), [')'].
bracketize(X - Y) --> ['('], bracketize(X), [-], bracketize(Y), [')'].
%bracketize(X // Y) --> ['('], bracketize(X), [//], bracketize(Y), [')'].

flatten(node(X)) --> [X].
flatten(X + Y) --> flatten(X), [+], flatten(Y).
flatten(X * Y) --> flatten(X), [*], flatten(Y).
flatten(X - Y) --> flatten(X), [-], flatten(Y).

expr(Z) --> num(Z).
expr(Z) --> num(X), [+], expr(Y), {Z is X+Y}.
expr(Z) --> num(X), [-], expr(Y), {Z is X-Y}.
expr(Z) --> num(X), [*], expr(Y), {Z is X*Y}.
%expr(Z) --> num(X), [//], expr(Y), {(Y =:= 0 -> Z = 0; Z = X//Y)}.

num(D) --> [D], {number(D)}.
num(D) --> ['('], expr(D), [')'].

unnode(E, R) :- flatten(E, Res, []), atomics_to_string(Res, R).

solve(L, V, R) :- 
    node(L, Expr), bracketize(Expr, Res, []), atomics_to_string(Res, R), expr(T, Res, []), T =:= V.
    
% ---

/**
solve([2,3,4,5,9], 2, E).
*/

