import 'dart:io';

void main() async {
  // Hello World
  print('Hello, World!');

  // Variables
  var name = 'Voyager I';
  var year = 1977;
  var antennaDiameter = 3.7;
  var flybyObjects = ['Jupiter','Saturn','Uranus','Neptune'];
  var image = {
    'tags': ['saturn'],
    'url': '//path/to/saturn.jpg'
  };

  // Controll flow statements
  if (year >= 2001) {
    print('21st centery');
  } else if (year >= 1901) {
    print('20st centery');
  }
  for (final object in flybyObjects) {
    print(object);
  }
  for (int month = 1; month <= 12; month++) {
    print(month);
  }
  while (year < 2016) {
    year += 1;
  }

  // Functions
  var result = fibonacci(20);
  print(result);

  flybyObjects.where((name) => name.contains('turn')).forEach(print);

  // Classes
  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();
  
  // Enums
  final yourPlanet = Planet.earth;
  
  if (!yourPlanet.isGiant) {
    print('Your planet is not a "giant planet".');
  }

  // Inheritance
  var ohsumi = Orbiter('おおすみ', DateTime(1970,2,11), 350.0);
  ohsumi.describe();

  // Mixins
  var vostok1 = PilotedCraft('Vostok-1', DateTime(1961, 4, 12));
  vostok1.describe();
  vostok1.describeCrew();

  // Interfaces and abstract classes
  var mock = MockSpaceship();
  mock.describeWithEmphasis();

  // Async
  printWithDelay('Async sample message.');
  createDescriptions(['a','b','c']);
  await for (var m in report(voyager, ['a','b','c'])) {
    print(m);
  }
  deleteDescriptions(['a','b','c']);
}

// Functions
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n-1) + fibonacci(n-2);
}

// Classes
class Spacecraft {
  String name;
  DateTime? launchDate;

  int? get launchYear => launchDate?.year;

  Spacecraft(this.name, this.launchDate) {
  }

  Spacecraft.unlaunched(String name) : this(name, null);

  void describe() {
    print('Spacecraft: $name');
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years year ago)');
    } else {
      print('Unlaunched');
    }
  }
}

// Enums
enum PlanetType { terrestrial, gas, ice }

enum Planet {
  mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
  earth(planetType: PlanetType.terrestrial, moons: 1, hasRings: false),
  // ...
  uranus(planetType: PlanetType.ice, moons: 27, hasRings: true),
  neptune(planetType: PlanetType.ice, moons: 14, hasRings: true);

  const Planet(
    {required this.planetType, required this.moons, required this.hasRings});

  final PlanetType planetType;
  final int moons;
  final bool hasRings;

  bool get isGiant =>
    planetType == PlanetType.gas || planetType == PlanetType.ice;
}

// Inheritance
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}

// Mixins
mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class PilotedCraft extends Spacecraft with Piloted {

  PilotedCraft(super.name, DateTime super.launchDate);
  // ..
}

// Interfaces and abstract classes
class MockSpaceship extends Describable implements Spacecraft {
  String name = 'MockSpaceship';
  DateTime? launchDate = DateTime(2023, 7, 7);

  int? get launchYear => launchDate?.year;

  void describe() {
    print('This is $name.');
  }
}

abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

// Async
const oneSecond = Duration(seconds: 1);
// ...
Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond);
  print(message);
}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

Stream<String> report(Spacecraft craft, Iterable<String> objects) async* {
  for (final object in objects) {
    await Future.delayed(oneSecond);
    yield '${craft.name} flies by $object';
  }
}

void deleteDescriptions(Iterable<String> objects) {
  for (final object in objects) {
    var file = File('$object.txt');
    file.deleteSync();
  }
}
