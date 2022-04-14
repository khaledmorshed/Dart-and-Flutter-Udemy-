import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum FilterOption {
  //assigning label of interger
  Camera,
  Gallery,
}

class ImageTakingWidget extends StatefulWidget {
  var imagePath;
 ImageTakingWidget({Key? key, this.imagePath}) : super(key: key);

  @override
  State<ImageTakingWidget> createState() => _ImageTakingWidgetState();
}

class _ImageTakingWidgetState extends State<ImageTakingWidget> {
  bool _isCamera = false;
  bool _isGellery = false;
  var imagePath;
  var imageUrl;

  Future pickedImageFromCamera() async {
    imagePath = null;
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imagePath = File(image.path);
      });
    }
  }

  Future pickedImageFromGellery() async {
    imagePath = null;
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 200,
            height: 150,
            margin: EdgeInsets.only(
              top: 8,
              right: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: imagePath == null
                ? Center(
                    child: Text(
                      'Upload image',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                // : FittedBox(
                //     // child: CircleAvatar(
                //     //   radius: 36,
                //     //   backgroundImage: FileImage(imagePath),
                //     // ),
                //     child: CircleAvatar(
                //       radius: 36,
                //       backgroundImage: FileImage(imagePath),
                //     ),
                //   ),

                : Center(
                    child: Image(image: FileImage(imagePath)),
                  )),
        PopupMenuButton(
          onSelected: (selectedValue) {
            setState(() {
              if (selectedValue == FilterOption.Camera) {
                // productsContainer.showFavoritesOnly();
                pickedImageFromCamera();
                //_isCamera = true;
              } else {
                // productsContainer.showAll();
                pickedImageFromGellery();
                //_isGellery = false;
              }
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (value) => [
            PopupMenuItem(
              child: Text("Camera"),
              value: FilterOption.Camera ,
            ),
            PopupMenuItem(
              child: Text("Gellery"),
              value: FilterOption.Gallery,
            )
          ],
        ),
      ],
    );
  }
}
