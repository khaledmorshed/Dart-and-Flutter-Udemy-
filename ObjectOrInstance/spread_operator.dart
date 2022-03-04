void main() {
  //general way
  // var list = [1, 2, 3];
  // var list2 = [];
  // list2.addAll(list);
  // print(list2);

  var list = [1, 2, 3];
  var list2 = [0, ...list];
  print(list2);
}
