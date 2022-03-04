import 'dart:async';

// a general class can act as a mixin class just with the keyword "with"
class A {
  void runA() {
    print("Show an apple");
  }
}

class B with A {}

void main() {
  
  var b = B();
  b.runA();
}
