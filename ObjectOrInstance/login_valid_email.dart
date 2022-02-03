import 'dart:html';
import 'dart:async';

void main() {
  final InputElement input = querySelector('input') as InputElement;
  final DivElement div = querySelector('div') as DivElement;

  //input is here stream of event object which will be provide by user
  //input.onInput.listen((dynamic event) => print(event.target.value));

  final validateEmail =
      StreamTransformer.fromHandlers(handleData: (dynamic inputValue, sink) {
    if (inputValue.contains('@')) {
      sink.add(inputValue);
    } else {
      sink.addError('Enter valid email');
    }
  });

  input.onInput
      .map((dynamic event) => event.target.value)
      .transform(validateEmail)
      .listen(
    (event) {
      div.innerHtml = "";
    },
    // here we took the error massage from sink.addError
    onError: (err) => div.innerHtml == err,
  );

  // input.onInput
  //     .map((dynamic event) => event.target.value)
  //     .transform(validateEmail).transform(validateNotGmailAddress)// we can multiple transform
  //     .listen(
  //   (event) {
  //     div.innerHtml = "";
  //   },
  //   // here we took the error massage from sink.addError
  //   onError: (err) => div.innerHtml == err,
  // );
}

