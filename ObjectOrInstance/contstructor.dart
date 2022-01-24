void main() {
  //var person = new Person(); //now new is optional to  create an instance or object
  var person = Person("morshed");
  person.printName();
}

class Person {
  String? firstName;

  //1. Person(name) {
  //   firstName = name;
  // }

  //2. Person(firstName) {
  //   firstName = firstName;
  // }

  //3. Person({this.firstName});

//4.
  Person(this.firstName);


  printName() {
    print(firstName);
  }
}
