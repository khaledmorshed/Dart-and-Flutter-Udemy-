import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';
import '../screens/orders_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              //you always go to home route
              Navigator.of(context).pushReplacementNamed('/');
              //Navigator.of(context).pushNamed(AuthScreen.routeName);
              //  Navigator.of(context).popUntil((route) {
              //   return route.settings.name == '/auth';
              // });

              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => AuthScreen()),
              //     (route) => route.isFirst);

              //Navigator.popUntil(context, (route) => route.isFirst);
              Provider.of<Auth>(context, listen: false).logout();
              //Navigator.of(context).pushNamed(AuthScreen.routeName);

              //Navigator.pop(context);
              //Navigator.popUntil(context, ModalRoute.withName('/auth'));

              // Navigator.of(context).popUntil((route) {
              //   return route.settings.name == '/auth';
              // });
            },
          ),
        ],
      ),
    );
  }
}
