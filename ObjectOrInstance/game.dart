import 'dart:html';
void main() {
  final ButtonElement? button = querySelector('button') as ButtonElement?;

  button!.onClick.timeout(
    new Duration(seconds: 1),
    onTimeout: (sink)=>sink.addError("you lost!!")
  ).listen((event) {},
    onError: (err)=>print(err)  
  );
}
