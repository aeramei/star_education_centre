// Superclass
class Animal {
  String speak;

  Animal(this.speak);

  void start() {
    print('$speak Animal is barking.');
  }
}

// Subclass inheriting from Animal
class Dog extends Animal {
  int legs;

  Dog(String speak, this.legs) : super(speak);

  @override
  void start() {
    print('$speak dog with $legs legs is barking.');
  }
}

void main() {
  Dog myDog = Dog('GR', 4);
  myDog.start();  // Output: GR dog with 4 legs is barking.
}


