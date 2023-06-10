void main() {
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
}

// Functions
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n-1) + fibonacci(n-2);
}
