//Mixins are defined in the Dart documentation as "a way of reusing a class’s
//code in multiple class hierarchies". Simply said, mixins allow you to plug in
//blocks of code without needing to create subclasses.

//Mixins are a very useful way of avoiding code duplication without inheritance.
// The fact that mixins can be also limited to work only with a particular class
// makes them powerful allies in the development of your apps.

//mixin is used for avoiding extra class or duplicate methods

mixin Fluttering {
  void flutter() {
    print('fluttering');
  }
}

abstract class Insect {
  void crawl() {
    print('crawling');
  }
}

abstract class AirborneInsect extends Insect with Fluttering {
  void buzz() {
    print('buzzing annoyingly');
  }
}

class Mosquito extends AirborneInsect {
  void doMosquitoThing() {
    crawl();
    flutter();
    buzz();
    print('sucking blood');
  }
}

//when mixin wants to extend a class then on is used
mixin Pecking on Bird {
  void peck() {
    print("pecking");
    chirp();
  }
}

abstract class Bird with Fluttering {
  void chirp() {
    print('chirp chirp');
  }

  // void flutter() {
  //   print('fluttering');
  // }
}

class Swallow extends Bird {
  void doSwallowThing() {
    chirp();
    flutter();
    print('eating a mosquito');
  }
}

class Sparrow extends Bird with Pecking {}

class BlueJay extends Bird with Pecking {}

void main() {
  // Mosquito().doMosquitoThing();
  // print("\n");
  // Swallow().doSwallowThing();
  // print("\n");
  Sparrow().peck();
 
}

/*mixin Fluttering2 {
  void flutter() {
    print('fluttering');
  }
}
//it is possible to use multiple mixin
abstract class AirborneInsect extends Insect with Fluttering,  Fluttering2{
  void buzz() {
    print('buzzing annoyingly');
  }
}*/
