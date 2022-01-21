void main() {
  //var person = new Person(); //now new is optional to  create an instance or object
  var person = Person();
  person.firstName = "morshed";
  person.printName();
}

class Person{
  String? firstName;

  printName() {
    print(firstName);
  }
}
