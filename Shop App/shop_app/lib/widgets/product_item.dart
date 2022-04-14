import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/auth.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  //const ProductItem({ Key? key }) : super(key: key);
  // final String? id;
  // final String? title;
  // final String? imageUrl;

  // //positioanl argument is setted in the constructor
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    //=>we get here the single product with id, title and everything
    //=>listen: false = when it set up then the entire widget build only one time although data
    //is changed over time
    //Consumer<Product> == it will not necessary if use
    //final product = Provider.of<Product>(context); but
    //withou listen: false it rebuild whole widget when data is change but sometimes we dont
    // need to rebuild whole widget.Actullay can have needed to rebuild only a portion of
    //that widget like IconButton of Favorites where consumer is setted.
    final product = Provider.of<Product>(context, listen: false);
    //listen = so this widget will not rebuild when cart's data will change
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    //print("widger rebuilds");
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreeen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl!,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          //it only rebuild IconButton when data is changed
          //child = if something stay inside of this then that portion will not rebuild
          //like = label : child and if we use label somewher then it not need to rebuild
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              onPressed: () {
                product.toggleFavoriteStatus(authData.token, authData.userId);
              },
              icon: Icon(
                product.isFavorite! ? Icons.favorite : Icons.favorite_border,
                color: Colors.redAccent,
                //color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItemIntoCart(product.id!, product.price!, product.title!);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                    //textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItemFromCart(product.id!);
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
