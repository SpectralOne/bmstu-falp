find_expression([SingleNumber],SingleNumber,SingleNumber).

find_expression(NumberList,Target,Expression):-
    append([X|Xs],[Y|Ys], NumberList),
    find_expression([X|Xs],Exp1,Exp1),
    find_expression([Y|Ys],Exp2,Exp2),
    (member(Expression,[Exp1+Exp2,Exp1-Exp2,Exp1*Exp2]);
        (Val2 is Exp2, Val2 =\= 0, Expression = (Exp1/Exp2))),
    (Target = Expression ; Target is Expression
      ; FloatTarget is Target*1.0, FloatTarget is Expression).

:- use_module(library(clpfd)).

oper(A, +, B, R) :- R #= A + B.
oper(A, -, B, R) :- R #= A - B.
oper(A, *, B, R) :- R #= A * B.
oper(A, //, B, R) :- R #= A // B.
oper(A, mod, B, R) :- R #= A - (A // B) * B.

find_expression([Op1, Op2, Op3]) :-
    oper(5, Op1, 2, R1),
    oper(R1, Op2, 3, R2),
    oper(R2, Op3, 4, 10).

