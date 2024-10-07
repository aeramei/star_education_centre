class Blood {
  String start() {
    return "Blood is bleeding";
  }
}

class Human {
  Blood blood = Blood();  // Human contains a Blood

  String start() {
    return blood.start();
  }
}

// Usage
void main() {
  Human human = Human();
  print(human.start());  // Output: Blood is bleeding
}


