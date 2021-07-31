import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/carts.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // final double amount;

  // ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl,
  //   this.amount,
  // );

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        color: Colors.black54,
        child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
                    arguments: product.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(product.imageUrl),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 0.0),
                  child: Text(
                    product.amount.toString(),
                    style: TextStyle(
                      backgroundColor: Colors.deepOrange,
                      color: Colors.white,
                      // color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              )

              // Image.network(
              //   imageUrl,
              //   fit: BoxFit.cover,
              // ),
              ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                onPressed: () {
                  product.isToggled();
                },
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(
                  product.id,
                  product.title,
                  product.amount,
                  product.imageUrl,
                  1,
                );
                // print(product.amount);
                // print(cart.items);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
