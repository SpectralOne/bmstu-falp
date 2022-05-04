domains
  num = integer

predicates
  nondeterm max2(num, num, num)
  nondeterm max3(num, num, num, num)

  nondeterm max2clipping(num, num, num)
  nondeterm max3clipping(num, num, num, num)

clauses
  max2(N1, N2, N2) :- N2 >= N1.
  max2(N1, N2, N1) :- N1 >= N2.

  max3(N1, N2, N3, N3) :- N3 >= N1, N3 >= N2.
  max3(N1, N2, N3, N2) :- N2 >= N1, N2 >= N3.
  max3(N1, N2, N3, N1) :- N1 >= N2, N1 >= N3.

  max2clipping(N1, N2, N2) :- N2 >= N1, !.
  max2clipping(N1, _, N1).

  max3clipping(N1, N2, N3, N3) :- N3 >= N2, N3 >= N1, !.
  max3clipping(N1, N2, _, N1) :- N1 >= N2, !.
  max3clipping(_, N2, _, N2).

goal
  %max2clipping(1, 4, Max).
  max3(133, 4, 5, Max).
