domains
  sex = symbol
  name = string
  man = man(sex, name)

predicates
  nondeterm parent(man, man)
  nondeterm grandparent(man, sex, name)

clauses
  grandparent(man(Sex, GrandPName), PSex, Name) :-
    parent(man(Sex, GrandPName), man(PSex, PName)),
    parent(man(PSex, PName), man(_, Name)).

  parent(man(f, "Natalia"), man(m, "Alexey")).
  parent(man(m, "Vasiliy"), man(m, "Alexey")).
  parent(man(f, "Galya"), man(f, "Natalia")).
  parent(man(m, "Sergey"), man(f, "Natalia")).
  parent(man(f, "Lyuda"), man(m,"Vasiliy")).
  parent(man(m, "Vasiliy"), man(m, "Vasiliy")).

goal
  %grandparent(man(f, GrandPName), _, "Alexey").
  %grandparent(man(m, GrandPName), _, "Alexey").
  %grandparent(man(_, GrandPName), _, "Alexey").
  %grandparent(man(f, GrandPName), f, "Alexey").
  grandparent(man(_, GrandPName), f, "Alexey").
