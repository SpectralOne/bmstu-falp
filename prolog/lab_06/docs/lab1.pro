domains
  name = string
  phone = integer
  surname = string
  
predicates
  nondeterm entry(phone, name, surname)

clauses
  entry(111, "John", "Smith").
  entry(222, "Adam", "Sandler").
  entry(333, "John", "Wick").
  entry(444, "Bruce", "Lee").
  entry(555, "Yuri", "Stroganov").
  
goal
  entry(Phone, "John", Surname).