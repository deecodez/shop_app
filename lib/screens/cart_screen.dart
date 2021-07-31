import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/carts.dart';
import 'package:shop_app/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'order now'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItemWidget(
                id: cart.items.values.toList()[i].id,
                productId: cart.items.keys.toList()[i],
                imageUrl: cart.items.values.toList()[i].imageUrl,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                title: cart.items.values.toList()[i].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}