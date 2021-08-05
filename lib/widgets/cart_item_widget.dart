import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/carts.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final String imageUrl;
  final double price;
  final int quantity;
  final String title;

  CartItemWidget({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do You want to remove item from cart'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40.0,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.0),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                height: 60,
                width: 60,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10.0),
                      Text('X $quantity'),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         IconButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               if (widget.quantity <= 1) {
                  //                 widget.quantity = 1;
                  //               } else {
                  //                 widget.quantity--;
                  //               }
                  //             });
                  //             // print(quantity);
                  //           },
                  //           icon: Icon(Icons.remove),
                  //         ),
                  //         SizedBox(width: 10.0),
                  //         Text(widget.quantity.toString()),
                  //         SizedBox(width: 10.0),
                  //         IconButton(
                  //           onPressed: () {
                  //             setState(() {
                  //               widget.quantity++;
                  //             });
                  //             // print(quantity);
                  //           },
                  //           icon: Icon(Icons.add),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text('\$$price'),
                      const SizedBox(width: 10.0),
                      Text(
                        'Total: \$${(price * quantity)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Are you sure?'),
                      content: Text('Do You want to remove item from cart'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<Cart>(context, listen: false)
                                .removeItem(productId);
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
