import 'dart:async';

class Cake {}

class Order {
  String? type;
  Order(this.type);
}

void main() {
  final controller = new StreamController();

  final order = new Order("banana");
  //sink one kind of vairable..and here is equavalent to order list
  controller.sink.add(order);

  //the main maker of cake who has taken order from order Inspector
  final baker = StreamTransformer.fromHandlers(
      //handleData will maintain which type of data is comming and this type comes from order.type
      // heres sink comes from transform(baker)
      handleData: (cakeType, sink) {
    if (cakeType == "chocolate") {
      sink.add(new Cake());
      // the steamTransformer can call multiple value
      sink.add(new Cake());
    } else {
      sink.addError('I cant bake that type!!!');
    }
  });
  //(i)steam as like as order inspector.its only care about the type.
  //(ii)here baker is added into stream.
  //(iii)here steam.map is order inspector, transform is cake maker = baker, listen is custumer who will
  //recieve his orederd cake
  controller.stream
      .map((order) {
        // map can recieve one value and aslo return one string at a time
        return order.type;
      })
      .transform(baker)
      //listen recieve data which come from StreamTransformer
      .listen((cake) {
        //this is initial argument function which takes true value from StreamTransformer
        print("Here your cake $cake");
      }, 
      //this the name parameter which takes onError form StreamTransfomer
      onError: (err) {
        print(err);
      });
}
