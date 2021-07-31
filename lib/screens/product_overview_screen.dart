import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/carts.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/products_grid.dart';
import 'package:badges/badges.dart';

enum FilterOption {
  Favorite,
  All,
}

class ProductOverViewScreen extends StatefulWidget {
//   final Map item;

// ProductOverViewScreen({this.item});
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

// @override
//     void initState(){
//        super.initState();
//        cart.itemCount

//     }

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    // final productContainer = Provider.of<Products>(context, listen: false);

    // final cart = Provider.of<Cart>(context, listen: false);

    // @override
    // void initState() {
    //   super.initState();
    //   cart.itemCount;
    // }

    // final cartNo = cart.itemCount;

    // setState(() {
    //   cartNo.whenComplete(() => null)
    // });

    // print(cart.itemCount);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Shop App'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorite) {
                  // productContainer.showFavorite();
                  _showOnlyFavorite = true;
                } else {
                  // productContainer.showAll();
                  _showOnlyFavorite = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favorite'),
                value: FilterOption.Favorite,
              ),
              PopupMenuItem(
                child: Text('All Products'),
                value: FilterOption.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              padding: EdgeInsets.all(10),
              badgeContent: Text(
                cart.itemCount.toString(),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
              child: ch,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorite),
    );
  }
}
