import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;

  ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    //this is listner..where it is setted only that widget or class will rebuild
    //not enitire app will rebuild
    //here we get all the product
    final productsData = Provider.of<ProductsProvider>(context);
    final products = showFavorites ? productsData.favoritesItem : productsData.items;

    //as like as ListView but it render only that items wich are present only in
    // the screen showed
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      // itemBuilder: (context, i) => ChangeNotifierProvider(
      //   create: (context) {
      //     //print("${products[i].id}");

      //     //it return single product for one iteration and tell Product to give one
      //     //Product to 'child: ProductItem' may be and it catch though Prodcut Provider
      //     return products[i];
      //   },

      //this process is best when we work with List.
      // And'.value' direct connected with provider
      //and recycle and store many concept have but i dont understand
      //And more importand .value means we reuse the provider not calling becasue inside of
      //main.dart file we call provider again ChangeNotifierProvider
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(
            //products[i],
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      //it defines the structure of the grid. how the grid will look like
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //image scale
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
