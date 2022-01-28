//it allows to work with json data.it importing from dart
import 'dart:convert';

void main() {
  var rawJson = '{"url": "http://blah.jpg", "id": 1}';

  var parseJson = json.decode(rawJson);
  var imageModel = new ImageModel.fromJson(parseJson);
  print(imageModel.id);
  print(imageModel.url);
}

// with imageModel class here is seperated all data of json
class ImageModel {
  int? id;
  String? url;

  ImageModel(this.id, this.url);// now this optional

  // this is called name constructor
  ImageModel.fromJson(parseJson) {
    id = parseJson['id'];
    url = parseJson['url'];
  }
}
