get_cell([R, C], Data, L) :-
    nth0(R,Data,L1),
    nth0(C,L1,L).

labyrinth(Map, Start, Finish):-
    labyrinth(Map, Start, Finish, [], [], Solution), !,
    reverse(Solution, S),
    replace_points(Map, Start, "S", SMap),
    replace_points(SMap, Finish, "F", FMap),
    lab_out(FMap, nl),
    print(S).

replace_points(Map, p(X,Y), Value, Res) :-
    append(RowPfx, [Row|RowSfx], Map),
    length(RowPfx, X),
    append(ColPfx, [_|ColSfx], Row),
    length(ColPfx, Y),
    append(ColPfx, [Value|ColSfx], RowNew),
    append(RowPfx, [RowNew|RowSfx], Res).

lab_out([], _) :- !.
lab_out([H|T], Sep) :-
    write(H), call(Sep), lab_out(T, Sep).

labyrinth(_, Finish, Finish,_, Out, Out).
labyrinth(Map, Start, Finish, Positions, Moves, Out) :-
    move(Move),
    update(Start, Move, NewState),
    \+ member(NewState, Positions),
    % FIXME: dont call size every path calculation
    size(Map, Xbound, Ybound),
    legal(NewState, Map, Xbound, Ybound),
    labyrinth(Map, NewState, Finish, [NewState|Positions], [Move|Moves], Out).

length_of(N, Ls) :-
    length(Ls, N).

size(Mss, R, C) :-
    length(Mss, R),
    maplist(length_of(C), Mss).

legal(p(X,Y), Map, Xbound, Ybound) :-
    X >= 0, Xbound>X,
    Y >= 0, Ybound>Y,
    get_cell([X,Y], Map, Z),
    Z \= x .

update(p(X, Y), up, p(X_new, Y)) :- X_new is X - 1.
update(p(X,Y), down, p(X_new, Y)) :- X_new is X + 1.
update(p(X,Y), left, p(X, Y_new)) :- Y_new is Y - 1.
update(p(X,Y), right, p(X, Y_new)) :- Y_new is Y + 1.

move(up).
move(down).
move(left).
move(right).

/**
labyrinth([
    [0,0,x,x,x,x],
    [x,0,x,0,x,0],
    [x,0,x,0,x,0],
    [x,0,0,0,x,0],
    [x,0,x,0,x,0],
    [x,0,0,0,0,0],
    [0,x,x,x,x,0]
], p(0,0), p(6,5)).
*/

