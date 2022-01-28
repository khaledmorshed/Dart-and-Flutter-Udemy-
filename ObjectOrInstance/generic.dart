void main() {
  var circleSlot = new Slot<Circle>();
  circleSlot.insert(new Circle());
}

class Circle {}

class Square {}

class Slot<T> {
  insert(T shape) {}
}
