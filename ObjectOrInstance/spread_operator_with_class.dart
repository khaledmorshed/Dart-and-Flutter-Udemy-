class Num {
  var list = [1, 2, 3];
  get f {
    return [0, ...list];
  }
}

void main() {
  var it = Num().f;
  print(it);
}
