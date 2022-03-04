import 'dart:async';

//mixin doesnt allow to create a constructor of it's inside
//object or instance can not be created of mixin class

mixin A {
  //the constructor can not be created
  //A(){}

  void runA() {
    print("Show an apple");
  }
}

//(i) = it is main than (ii)
//class B with A {}

//(ii)
//we can overide mixin's method
class B with A {
  void runA() {
    print("Show an apple and banana");
  }
}

void main() {
  //it is not allow for mixin
  //var a = A();

  var b = B();
  b.runA();
}
