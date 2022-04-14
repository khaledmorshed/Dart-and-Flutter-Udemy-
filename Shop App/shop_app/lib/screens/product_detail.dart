import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailScreeen extends StatelessWidget {
  //const ProductDetailScreeen({ Key? key }) : super(key: key);

  static String routeName = "ProductDetailScreeen";

  @override
  Widget build(BuildContext context) {
    //this is id and this for extract id
    //I can get all product data with this id
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    //listen: false meaning it not rebuild when other widget rebuild
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text("${loadedProduct.title}"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .60,
            width: double.infinity,
            child: Image.network(
              loadedProduct.imageUrl!,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "\$${loadedProduct.price!}",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Text(
              loadedProduct.description!,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
