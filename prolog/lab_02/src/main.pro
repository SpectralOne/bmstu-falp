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
  
predicates
  nondeterm phone(surname, phone, address)
  nondeterm car(surname, mark, color, price)
  nondeterm bank_depositor(surname, bank, id, amount)
  nondeterm car_by_phone(phone, surname, mark, price)
  nondeterm only_mark_by_phone(phone, mark)
  nondeterm data_by_surname_and_city(surname, city, street, bank, phone)
  
clauses
  phone("Smith", "111", addr("Washington", "liberty st", 1, 1)).
  phone("Lee", "222", addr("Uhan", "portovaya", 13, 37)).
  phone("Stroganov", "333", addr("Dekanat", "IU7", 14, 88)).
  phone("Sandler", "666", addr("Moscow", "Wall-street", 13, 37)).
  car("Smith", "lada", "red", 100).
  car("Lee", "ford", "yellow", 1000).
  car("Lee", "bmw", "black", 3000).
  car("Stroganov", "bike", "silver", 10).
  car("Smith", "mercedes", "white", 3200).
  bank_depositor("Smitth", "Bank of America", 1, 10000).
  bank_depositor("Lee", "Sberbank", 2, 40000).
  bank_depositor("Lee", "Tinkoff", 3, 100).
  bank_depositor("Stroganov", "Alfabank", 228, 10).
  bank_depositor("Smith", "Maze", 4, 90000).
  
  car_by_phone(Phone, Surname, Mark, Price) :- phone(Surname, Phone, _), car(Surname, Mark, _, Price).
  only_mark_by_phone(Phone, Mark) :- car_by_phone(Phone, _, Mark, _).
  data_by_surname_and_city(Surname, City, Street, Bank, Phone) :- phone(Surname, Phone, addr(City, Street, _, _)), bank_depositor(Surname, Bank, _, _).
  
goal
  %car_by_phone("333", Surname, Mark, Price).
  %only_mark_by_phone("333", Mark).
  data_by_surname_and_city("Lee", "Uhan", Street, Bank, Phone).
