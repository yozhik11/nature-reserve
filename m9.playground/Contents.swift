class Animal {
  var energy: Int
  var weight: Int
  var currentAge: Int
  let maximumAge: Int
  let name: String

  // проверка на возвраст
  var isTooOld: Bool {currentAge >= maximumAge}

  //проверка жизненных показателей
  var tooLate: Bool {self.isTooOld || weight <= 0 || energy <= 0}

  required init (name: String, energy: Int, weight: Int, maximumAge: Int){
    self.name = name
    self.energy = energy
    self.weight = weight
    self.maximumAge = maximumAge
    self.currentAge = 1
  }
  
  //живность спит
  func sleeping () {
    energy += 5
    currentAge += 1
    print ("\(name) спит")
  }

  //живность ест
  func eating () {
    energy += 3
    weight += 1
    tryIncrementAge ()
    print ("\(name) кушает")
  }

  //живность идет
  func walking () {
    energy -= 5
    weight -= 1
    tryIncrementAge ()
    print ("\(name) куда-то спешит")
  }

  //возможное увеличение возраста
  private func tryIncrementAge () {
    if Bool.random() && !tooLate {
      currentAge += 1
    }
  }

  // рождение новой животинки
  func newAnimal () -> Animal {
    let baby = Animal (name: self.name, energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maximumAge: self.maximumAge)
    print ("В заповеднике прибыло: зовут \(baby.name), возраст \(baby.currentAge), силища \(baby.energy), вес \(baby.weight)")
    return baby
  }
}

//подкласс с птичками
class Bird: Animal {
  override func walking () {
    super.walking ()
    print ("А точнее - летит")
  }

  // рождение птицы
  override func newAnimal () -> Bird {
    let baby = Bird (name: self.name, energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maximumAge: self.maximumAge)
    print ("Родилась птичка: зовут \(baby.name), возраст \(baby.currentAge), силища \(baby.energy), вес \(baby.weight)")
    return baby
  }
}

//подкласс с рыбами
class Fish: Animal {
  override func walking () {
    super.walking ()
    print ("А точнее - плывет")
  }

  // рождение рыбы
  override func newAnimal () -> Fish {
    let baby = Fish (name: self.name, energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maximumAge: self.maximumAge)
    print ("Родилась рыба: зовут \(baby.name), возраст \(baby.currentAge), силища \(baby.energy), вес \(baby.weight)")
    return baby
  }
}

//подкласс с собачками
class Dog: Animal {
  override func walking () {
    super.walking()
    print ("А точнее - бежит")
  }

  // рождение собаки
  override func newAnimal () -> Dog {
   let baby = Dog (name: self.name, energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maximumAge: self.maximumAge)
   print ("Родилась собака: зовут \(baby.name), возраст \(baby.currentAge), силища \(baby.energy), вес \(baby.weight)")
   return baby
  }
}

//мне нужен дракон
class Dragon: Animal {
  override func walking () {
    super.walking ()
    print ("Дракон летит!")
  }

  // рождение дракона
  override func newAnimal () -> Dragon {
    let baby = Dragon (name: self.name, energy: Int.random(in: 1...10), weight: Int.random(in: 1...5), maximumAge: self.maximumAge)
    print ("Родился дракон: зовут \(baby.name), возраст \(baby.currentAge), силища \(baby.energy), вес \(baby.weight)")
    return baby
  }
}

//класс создания заповедника
class NatureReserve {
  var animals: [Animal]

  init (animals: [Animal]) {
    self.animals = animals
  }

//цикл жизни животных
  func lifeCircle (years: Int) {
    //рандомное действие
    for i in 1...years {
      print ("Год \(i)")
      for oneAnimal in animals {
        switch Int.random(in: 1...4) {
        case 1: oneAnimal.walking()
        case 2: oneAnimal.eating()
        case 3: oneAnimal.sleeping()
        default: animals.append(oneAnimal.newAnimal())
        }
      }

      //удаляем животных, если превысили возраст или обессилили
      animals.removeAll (where: {$0.tooLate})

      //прерывание цикла, если больше никого нет или вывод кол-ва выживших (какие-то голодные игры)
      if animals.isEmpty {
        print ("Все умерли(")
        break
      } else if i == years {
        print ("Выжило \(animals.count)")
       // animals.forEach {print($0.about())}
      }
    }
  }
}

//создание заповедника.

var animalsInReserve = NatureReserve(animals: [
  Bird(name: "Воробей", energy: 10, weight: 6, maximumAge: 3),
  Bird(name: "Синица", energy: 15, weight: 5, maximumAge: 3),
  Bird(name: "Орел", energy: 20, weight: 15, maximumAge: 3),
  Bird(name: "Чайка", energy: 12, weight: 9, maximumAge: 3),
  Bird(name: "Ястреб", energy: 23, weight: 8, maximumAge: 3),
  Fish(name: "Акула", energy: 7, weight: 12, maximumAge: 3),
  Fish(name: "Камбала", energy: 3, weight: 4, maximumAge: 3),
  Fish(name: "Окунь", energy: 6, weight: 2, maximumAge: 3),
  Dog(name: "Шнауцер", energy: 6, weight: 5, maximumAge: 3),
  Dog(name: "Овчарка", energy: 7, weight: 12, maximumAge: 3),
  Animal(name: "Непонятно", energy: 9, weight: 8, maximumAge: 3),
  Animal(name: "Странно", energy: 8, weight: 5, maximumAge: 3),
  Dragon(name: "Красный дракон", energy: 13, weight: 23, maximumAge: 5),
  Dragon(name: "Ледяной дракон", energy: 17, weight: 20, maximumAge: 5),
  Dragon(name: "Зеленый дракон", energy: 15, weight: 27, maximumAge: 5)])

// иииии!
animalsInReserve.lifeCircle (years: 3)
