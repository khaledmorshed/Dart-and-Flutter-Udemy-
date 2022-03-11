import 'dart:async';

void main() {
  var myFuture = Future(() {
    return 'Hello';
  });
  print("This runs first!");
  myFuture.then((value) => print(value)).catchError((e) {
    //if first .then get error then error will catch first after then second .then will 
    //start to execute
    return print(e);
  }).then((_) {
    print("after hello is done");
  });
  print("This also runs before the future is done!");
}
