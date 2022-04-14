import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import '../providers/products_provider.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';
import 'providers/orders.dart';
import '../screens/auth_screen.dart';
import '../providers/auth.dart';
import '../screens/products_overview_screen.dart';
import '../screens/splash_screen.dart';

//void main() => runApp(MyApp());
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      //   options: FirebaseOptions(
      //   apiKey: "AIzaSyBiStin-Uv1pMKCO6sdl0M5vTtWs8RZ0Lo",
      //   appId: "1:848631223476:android:7e5fba1421641644df33e1",
      //   messagingSenderId: "848631223476",
      //   projectId: "contacktlist",
      // ),
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ChangeNotifierProvider clean old data from the memory
    //ChangeNotifierProvider will not rebuild entire app
    //only that widget will rebuild where listner is setted

    //'.value' means our value doesnt depend on context
    // return ChangeNotifierProvider.value(
    //  value:  ProductsProvider(),
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ChangeNotifierProvider(
        //   create: (BuildContext context /*_ = i can give insted*/) {
        //     return ProductsProvider();
        //   },
        // ),

        //when Auth() will change then ChangeNotifierProxyProvider(ProductsProvider) will change
        //and rebuild only not all provider.
        // Auth() is now dependency of ChangeNotifierProxyProvider
        //Auth here first one on which ProductsProvider depend and second ProductsProvider
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          //previousProduct == To store previous value of ProductsProvider
          //previousProduct!.items == it store previous product item which was stored into
          // 'List<Product> _items = []' inside of ProductsProvider
          //this all exchanging for only get authenticated user's token
          //create: ProductsProvider inside of this just assigned some dummy value
          create: (context) => ProductsProvider('', null, []),
          //when it rebuilds then we dont want to loose our previous data
          update: (context, auth, previousProduct) => ProductsProvider(
              auth.token,
              auth.userId,
              previousProduct == null ? [] : previousProduct.items),
        ),
        //ChangeNotifierProxyProvider2() = we can use more proxy provider with 2, 3, 4 number added
        // ChangeNotifierProvider.value(
        //   value: Cart(),
        // ),

        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => Orders(),
        // )
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders('', null, []),
          //when it rebuilds then we dont want to loose our previous data
          update: (context, auth, previousOrders) => Orders(auth.token,
              auth.userId, previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      //MaterialApp will get above all provider. in this way the whole app will get access
      // all provider
      //for consumer here we dont want to rebuild the above code we we will rebuild just
      // Materialapp
      child: Consumer<Auth>(
        //when auth changes then it will automatically rebuild
        builder: (context, auth, _) => MaterialApp(
          
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Roboto',
          ),
          //if user authenticated then go ProductsOverviewScreen
          //are you authenticated yes then go ProductsOverviewScreen
          //if not then try to autoLogin. if wainting show splashScreen it not
          //go to AuthScreen
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen() : /*authResultSnapshot.data != null  ?
                          ProductsOverviewScreen() : */AuthScreen(),
                ),
          routes: {
            ProductDetailScreeen.routeName: (ctx) => ProductDetailScreeen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
            AuthScreen.routeName: (context) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
