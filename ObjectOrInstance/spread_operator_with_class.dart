class Num {
  var list = [1, 2, 3];
  //this getter
  get f {
    return [0, ...list];
  }
}

void main() {
  var it = Num().f;
  print(it);
}
