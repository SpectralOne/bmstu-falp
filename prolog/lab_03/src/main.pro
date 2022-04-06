domains
  surname = string
  city, street = string
  house, flat = integer
  phone = string
  address = addr(city, street, house, flat)
  mark = string
  color = string
  price = integer
  bank = string
  id, amount = integer
  name = string
  ind_property = building(name, price);
    region(name, price);
    water_transport(name, color, price);
    car(name, color, price).
  
predicates
  nondeterm phone(surname, phone, address)
  nondeterm bank_depositor(surname, bank, id, amount)
  nondeterm owner(surname, ind_property)

  nondeterm all_objects(surname, name)
  nondeterm all_objects_with_price(surname, name, price)
  
clauses
  phone("Smith", "111", addr("Washington", "liberty st", 1, 1)).
  phone("Lee", "222", addr("Uhan", "portovaya", 13, 37)).
  phone("Stroganov", "333", addr("Dekanat", "IU7", 14, 88)).
  phone("Sandler", "666", addr("Moscow", "Wall-street", 13, 37)).
  owner("Smith", car("lada", "red", 100)).
  owner("Lee", car("ford", "yellow", 1000)).
  owner("Lee", car("bmw", "black", 3000)).
  owner("Stroganov", car( "bike", "silver", 10)).
  owner("Smith", car("mercedes", "white", 3200)).
  owner("Lee", region("football field", 100)).
  owner("Sandler", building("Moscow center", 1000)).
  owner("Stroganov", region("rublevka", 1000000)).
  owner("Sandler", building("village", 3000)).
  owner("Stroganov", water_transport("katamaran", "red", 999999999)).
  owner("Smith", building("tower", 200)).
  owner("Lee", building("tent", 0)).
  bank_depositor("Smitth", "Bank of America", 1, 10000).
  bank_depositor("Lee", "Sberbank", 2, 40000).
  bank_depositor("Lee", "Tinkoff", 3, 100).
  bank_depositor("Stroganov", "Alfabank", 228, 10).
  bank_depositor("Smith", "Maze", 4, 90000).

  all_objects(Surname, Name) :- owner(Surname, car(Name, _, _)).
  all_objects(Surname, Name) :- owner(Surname, building(Name, _)).
  all_objects(Surname, Name) :- owner(Surname, region(Name, _)).
  all_objects(Surname, Name) :- owner(Surname, water_transport(Name, _, _)).

  all_objects_with_price(Surname, Name, Price) :- owner(Surname, car(Name, _, Price)).
  all_objects_with_price(Surname, Name, Price) :- owner(Surname, building(Name, Price)).
  all_objects_with_price(Surname, Name, Price) :- owner(Surname, region(Name, Price)).
  all_objects_with_price(Surname, Name, Price) :- owner(Surname, water_transport(Name, _, Price)).

goal
  %all_objects("Stroganov", Name).
  all_objects_with_price("Stroganov", Name, Price).
