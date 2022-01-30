class ImageModel {
  int? id;
  String? url;
  String? title;

  ImageModel(this.id, this.url, this.title);

  //(i). it is called name constructor and "Map<String, dynamic>": this optional
  ImageModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    url = parsedJson['url'];
    title = parsedJson['title'];
  }

  //this is as same as (i)
  //   ImageModel.fromJson(Map<String, dynamic> parsedJson)
  //   :
  //   id = parsedJson['id'],
  //   url = parsedJson['url'],
  //   title = parsedJson['title'];
  

}

