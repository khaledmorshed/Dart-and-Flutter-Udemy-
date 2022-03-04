import 'dart:async';

void main() {
  final controller = StreamController.broadcast();

  final newSteam = controller.stream.map((event) {
    print(event);
    return event;
  });

//five StreamSubscriptioin
  newSteam.listen((event) {});
  newSteam.listen((event) {});
  newSteam.listen((event) {});
  newSteam.listen((event) {});
  newSteam.listen((event) {});

  controller.sink.add(1);
}
