import 'dart:developer';

class Animal {
  void eat() {
    print('Animal is eating');
  }
}

class Dog extends Animal {
  @override
  void eat() {
    print('Dog is eating');
  }

  void bark() {
    print('Dog is barking');
  }
}

void main() {
  Dog dog = Dog();
  Animal animal = Animal();
  dog.eat(); // Outputs: Animal is eating
  dog.bark(); // Outputs: Dog is barking
  animal.eat();
}
