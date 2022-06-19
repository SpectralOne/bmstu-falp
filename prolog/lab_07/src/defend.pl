:- use_module(library(clpfd)).

fn(plus, [1, 2], [3]).
fn(plus, [1, 1], [2]).
fn(plus, [0, 1], [1]).

fn(minus, [4, 1], [3]).
fn(minus, [3, 1], [2]).
fn(minus, [2, 1], [1]).
fn(minus, [1, 1], [0]).

list_empty([]) :- true.
list_empty([_|_]) :- false.

delete_first(X, L, R) :- select(X, L, R), !.

flattn([]) --> [], !.
flattn([A|T]) --> {\+is_list(A)}, [A, ' '], !, flattn(T).
flattn([A|T]) --> flattn(A), flattn(T).

flatten(L, X) :- phrase(flattn(L), X).

match(_, [], R, Res) :- Res = R.
match(InList, OutList, R, Res) :-
    fn(F, In, Out), intersection(InList, In, InR), intersection(OutList, Out, [OutR|_]),
    ( list_empty(InR); \+ number(OutR)
      -> Res = R
      ; delete_first(OutR, OutList, NewOut),
        flatten([F, '(',  In, ')' , '=', OutR], FltR),
        atomics_to_string(FltR, Sr),
        append([R, [Sr]], NewR),
        match(InList, NewOut, NewR, Res)).

