import 'package:flutter/material.dart';
import '../model/image_model.dart';

//because ImageList not going to change its instance
class ImageList extends StatelessWidget {
  //because we can't change any varibale in future inside of StatelessWidget
  //for this reason final key word must need
  final List<ImageModel> images; // ekhane sokol image abong image er sob property ache jokhon json theke data ana hoi
  ImageList(this.images);

  // ListView = it builds all element of array instantly. if 5000 images are in list then it will
  // build instant
  // But named constructor ListView.builder = it will build as demand. it means when user scrolling
  // then it loading and when user goes to end then it build or loads whole list. its performance is better
  Widget build(context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        // images[index] is holding just one image with all data of image
        return buildImage(images[index]);
      },
    );
  }
}

Widget buildImage(ImageModel image) {
  // here containder is taking place with border and space and image
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.red),
    ),
    //padding takes space inside of container
    padding: EdgeInsets.all(20),
    //margin takes space outside of container
    margin: EdgeInsets.all(20.0),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Image.network(image.url.toString()),
        ),
        Text(image.title.toString())
      ],
    ),
  );
}
