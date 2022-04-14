import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum FilterOption {
  //assigning label of interger
  Camera,
  Gallery,
}

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _titleController = TextEditingController();
  final _pirceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var imagePath;
  var imagePathToString;
  //when user will edit product it will be setted null.
  //For hangeDependencie function
  var _editingImageUrl;
  //For updateProduct function
  var updatemageUlrfromUpload;

  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );
  //var _initValues;

  // void forEditingProduct() {
  var _initValues = {
    'id': null,
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  // }

  //var imagePath;

  Future pickedImageFromCamera() async {
    //imageUrl = null;
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        imagePath = File(image.path);
        //uploadProfileImage();
        //imageUrl = "http://" + "$image";
      });
    }
    // _editedProduct = Product(
    //   title: _editedProduct.title,
    //   price: _editedProduct.price,
    //   description: _editedProduct.description,
    //   imageUrl: imageUrl,
    //   id: _editedProduct.id,
    //   isFavorite: _editedProduct.isFavorite,
    // );
  }

  Future pickedImageFromGellery() async {
    //imageUrl = null;
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = File(image.path);
        //uploadProfileImage();
      });
    }
    // _editedProduct = Product(
    //   title: _editedProduct.title,
    //   price: _editedProduct.price,
    //   description: _editedProduct.description,
    //   imageUrl: imageUrl,
    //   id: _editedProduct.id,
    //   isFavorite: _editedProduct.isFavorite,
    // );
    print(
        "LKDJFDLKFJLLLLLLLLLLLLLLLLLLFJDKLFJDLSFJDLSKFJDLKFJDLSKJFLSDKJFLKSDLfLKDJFLKDJFDSLLLLLLLLLLLSDOIFJSD: + Gallery ${imagePath}");
  }

  Future uploadProfileImage() async {
    String image = imagePath.toString();
    var _image = image.split("/")[6];

    Reference reference =
        FirebaseStorage.instance.ref().child('/productsImage/${_image}');
    UploadTask uploadTask = reference.putFile(imagePath);

    TaskSnapshot snapshot = await uploadTask;
    imagePathToString = await snapshot.ref.getDownloadURL();
    print(
        "FJDLKFJLDKJFLKDSJFLKDSJFLKSDJFLSDKJFSDKLFLSDKJFLSDKJFSDKLJFSLDKFJSLDFKLSDJFLSDKJFLSDKJFLSKJFLSDFJDFD SetaState uploadProfileImage function ${imagePathToString}");

    // ProductsProvider().downloadImage(imagePathToString);
    // print(
    // "dlfkjmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    //print(
    //  "LKDJFDLKFJLLLLLLLLLLLLLLLLLLFJDKLFJDLSFJDLSKFJDLKFJDLSKJFLSDKJFLKSDLfLKDJFLKDJFDSLLLLLLLLLLLSDOIFJSD: + after dwonload in upload ${imagePathToString}");
    return imagePathToString;
  }

  var _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    /*_imageUrlFocusNode.addListener(_updateImageUrl);*/
    // if (Provider.of<ProductsProvider>(context, listen: false).authToken == null) {
    //   Navigator.pop(context);
    // }
    super.initState();
  }

  //for product inforamtion upadating and editing purpose it is setted
  //it is as like as initState which runs before build is executed but
  //didCahngeDepencies build multiple time
  @override
  void didChangeDependencies(/*final String productId*/) {
    print(
        "KFJDSLFKJDLKFDLKFJDLSKJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDS: + in didchange only");
    if (_isInit) {
      //final productId = ModalRoute.of(context)!.settings.arguments.toString();
      //if user add item firt time then there will be no id but still this will build
      //for this reason 'productId != null' is setted
      //when user will edit a product then there will be productId of that product
      //print("KLDJFDKLFJDKLFDKLFDKFDK: $productId");
      //if (productId != 0) {
      //find all data of product for this productId so that we can upadate

      List productId =
          (((ModalRoute.of(context)!.settings.arguments) ?? [0]) as List);
      // if (productId[0] != 0) {
      //   //print("I AM GREAT STUPIT CODE");
      //   //forEditingProduct();
      //   hangeDependencie(productId[0]);
      // }
      print(
          "KFJDSLFKJDLKFDLKFJDLSKJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDS: + in didchange id before  = ${_editedProduct.id} + ${productId[0]}");
      if (productId[0] != 0) {
        print(
            "KFJDSLFKJDLKFDLKFJDLSKJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDS: + in didchange id after = ${_editedProduct.id} + ${productId[0]}");
        final productData =
            Provider.of<ProductsProvider>(context, listen: false)
                .findById(productId[0].toString());
        _editedProduct = productData;
        _initValues = {
          'id': _editedProduct.id!,
          'title': _editedProduct.title!,
          'description': _editedProduct.description!,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        // _imageUrlController.text = _editedProduct.imageUrl!;
        //now edit _editingImageUrl has value with image url which is comming firebase
        _editingImageUrl = _editedProduct.imageUrl;
        _titleController.text = _editedProduct.title!;
        _descriptionController.text = _editedProduct.description!;
        _pirceController.text = _editedProduct.price.toString();
      }
      print(
          "KFJDSLFKJDLKFDLKFJDLSKJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDS: + in didchange title = ${_editedProduct.title}");
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    /*_imageUrlFocusNode.removeListener(_updateImageUrl);*/
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  /*void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
    //extra adeed
    else {
      return;
    }
  }*/

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    //uploadProfileImage();
    // _editedProduct = Product(
    //   title: _editedProduct.title,
    //   price: _editedProduct.price,
    //   description: _editedProduct.description,
    //   imageUrl: _editedProduct.imageUrl,
    //   id: _editedProduct.id,
    //   isFavorite: _editedProduct.isFavorite,
    // );
    var bloc = Provider.of<ProductsProvider>(context, listen: false);
    if (imagePath == null && _editingImageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please upload an image",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.startToEnd,
        ),
      );
      return;
    }
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    _isLoading = true;
    print(
        "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL + _editedProduct.id before contdition in save: ${_editedProduct.id}");
    if (_editedProduct.id != null) {
      print(
          "LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL + _editedProduct.id After condition in save: ${_editedProduct.id}");
      try {
        // print(
        //   "KFJDSLFKJDLKFDLKFJDLSKJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDS: + imagePath = $imagePath");
        if (imagePath != null) {
          //setState(() {
          //print(
          //    "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE. before null $_editingImageUrl");
          //_editingImageUrl = null;
          // print(
          //     "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE. after null $_editingImageUrl");
          //});

          uploadProfileImage().then((imageUlrfromUploadimage) {
            //print(
            //    "fdjkldssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssa WITH imagePath UPADTE = $imagePath");
            //print(
            //     "LKDJFDLKFJLLLLLLLLLLLLLLLLLLFJDKLFJDLSFJDLSKFJDLKFJDLSKJFLSDKJFLKSDLfLKDJFLKDJFDSLLLLLLLLLLLSDOIFJSD: +  in save ${imageUlrfromUploadimage}");
            _editedProduct = Product(
              title: _editedProduct.title,
              price: _editedProduct.price,
              description: _editedProduct.description,
              imageUrl: imageUlrfromUploadimage,
              id: _editedProduct.id,
              isFavorite: _editedProduct.isFavorite,
            );
            print(
                "LKDJFDLKFJLLLLLLLLLLLLLLLLLLFJDKLFJDLSFJDLSKFJDLKFJDLSKJFLSDKJFLKSDLfLKDJFLKDJFDSLLLLLLLLLLLSDOIFJSD: +  in save in if ${_editedProduct.title}");
            //Provider.of<ProductsProvider>(context)
            bloc.updateProduct(_editedProduct.id!, _editedProduct);

            // _editingImageUrl = imageUlrfromUploadimage;

            //ProductsProvider()
            //bloc.updateProduct(_editedProduct.id!, _editedProduct);
            // print(
            //      "EIEIEIEIEIEIEEIIEEIEIEIEIEIEIEIEIEIEIEIEIEIEIEIIEIEIEIEIEIEIEEIIEIEIEIEIEIEIEIEIEIEIEIIEIEIEIEIEIEIIEIEIEIEIEIIEIEIEIIEIEIEIIEIEIEIIEEIEIEIEI ${_editedProduct.imageUrl}");
            // Provider.of<ProductsProvider>(context, listen: false)
            //     .updateProduct(_editedProduct.id!, _editedProduct);
          });
        } else {
          // print(
          //    "KFJDSLFKJDLKFDLKFJDLSKJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDS: + WITHOUT imagePath UPDATE = $imagePath");
          //Provider.of<ProductsProvider>(context).
          bloc.updateProduct(_editedProduct.id!, _editedProduct);
          print(
              "KFJDSLFKJDLKFDLKFJDLSKJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJDS: + title before update in else in save = ${_editedProduct.title}");
          //bloc.updateProduct(_editedProduct.id!, _editedProduct);
        }
      } catch (err) {
        throw err;
      }
    } else {
      try {
        uploadProfileImage().then((imageUlrfromUploadimage) {
          //print(
          //    "fdjkldssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssa");
          // print(
          //    "LKDJFDLKFJLLLLLLLLLLLLLLLLLLFJDKLFJDLSFJDLSKFJDLKFJDLSKJFLSDKJFLKSDLfLKDJFLKDJFDSLLLLLLLLLLLSDOIFJSD: +  in save ${imagePathToString.toString()}");
          _editedProduct = Product(
            title: _editedProduct.title,
            price: _editedProduct.price,
            description: _editedProduct.description,
            imageUrl: imageUlrfromUploadimage,
            id: _editedProduct.id,
            isFavorite: _editedProduct.isFavorite,
          );
          //Provider.of<ProductsProvider>(context)
          bloc.addProduct(_editedProduct);
          //bloc.addProduct(_editedProduct);
        });

        // _editedProduct = Product(
        //   title: _editedProduct.title,
        //   price: _editedProduct.price,
        //   description: _editedProduct.description,
        //   imageUrl: imageUrl,
        //   id: _editedProduct.id,
        //   isFavorite: _editedProduct.isFavorite,
        // );

        // await Provider.of<ProductsProvider>(context, listen: false)
        //     .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
// ((data['softskills'] ?? []) as List)
// (data['softskills'] as List)?

    // List productId =
    //     (((ModalRoute.of(context)!.settings.arguments) ?? [0]) as List);
    // if (productId[0] != 0) {
    //   //print("I AM GREAT STUPIT CODE");
    //   //forEditingProduct();
    //   hangeDependencie(productId[0]);
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  imageTaking(),
                  form(context),
                ],
              ),
            ),
    );
  }

   imageTaking() {
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
          child: imagePath == null && _editingImageUrl == null
              ? Center(
                  child: Text(
                    'Upload image',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              : (_editingImageUrl == null || imagePath != null
                  ? Center(
                      child: Image(
                        image: FileImage(imagePath),
                      ),
                    )
                  : Center(
                      child: Image(
                      image: NetworkImage(_editingImageUrl),
                    )
                      // CircleAvatar(
                      //   backgroundImage: NetworkImage(_editingImageUrl),
                      // ),
                      )),
        ),
        PopupMenuButton(
          onSelected: (selectedValue) {
            setState(() {
              if (selectedValue == FilterOption.Camera) {
                // productsContainer.showFavoritesOnly();
                setState(() {
                  pickedImageFromCamera();
                });

                //_isCamera = true;
              } else {
                // productsContainer.showAll();
                setState(() {
                  pickedImageFromGellery();
                });

                //_isGellery = false;
              }
            });
          },
          icon: Icon(Icons.more_vert),
          itemBuilder: (value) => [
            PopupMenuItem(
              child: Text("Camera"),
              value: FilterOption.Camera,
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

  Expanded form(BuildContext context) {
    return Expanded(
      child: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            TextFormField(
              //if(productId[0] != null)

              //initialValue: _initValues['title'],
              // initialValue: productId[0] != 0
              //     ? _initValues['title']
              //     : Product(
              //         id: null,
              //         title: '',
              //         description: '',
              //         price: 0,
              //         imageUrl: ''),
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              controller: _titleController,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please provide a value.';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: value,
                  price: _editedProduct.price,
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),
            TextFormField(
              //initialValue: _initValues['price'],
              /*initialValue: productId[0] != 0
                      ? _initValues['price']
                      : Product(
                          id: null,
                          title: '',
                          description: '',
                          price: 0,
                          imageUrl: ''),*/
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: _pirceController,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a price.';
                }
                //tryParse may check wheather it is null or not
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number.';
                }
                if (double.parse(value) <= 0) {
                  return 'Please enter a number greater than zero.';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: _editedProduct.title,
                  price: double.parse(value!),
                  description: _editedProduct.description,
                  imageUrl: _editedProduct.imageUrl,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),
            TextFormField(
              //initialValue: _initValues['description'],
              //initialValue: _initValues['descriptiontle'],
              /*initialValue: productId[0] != 0
                      ? _initValues['description']
                      : Product(
                          id: null,
                          title: '',
                          description: '',
                          price: 0,
                          imageUrl: ''),*/
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              controller: _descriptionController,
              focusNode: _descriptionFocusNode,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description.';
                }
                if (value.length < 3) {
                  return 'Should be at least 3 characters long.';
                }
                return null;
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: _editedProduct.title,
                  price: _editedProduct.price,
                  description: value,
                  imageUrl: _editedProduct.imageUrl,
                  id: _editedProduct.id,
                  isFavorite: _editedProduct.isFavorite,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
