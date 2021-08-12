import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );
  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100.0,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('Do You want to delete product'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text('No'),
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () async {
                          try {
                            Navigator.of(ctx).pop(true);
                            await Provider.of<Products>(context, listen: false)
                                .deleteProduct(id);
                          } catch (error) {
                            scaffold.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Deleting Failed!',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
