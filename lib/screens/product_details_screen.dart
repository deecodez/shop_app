import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/carts.dart';
import 'package:shop_app/provider/products.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity <= 1) {
        quantity = 1;
      } else {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments
        as String; // this return the id of each of product

    //Getting all products based on id
    final loadedProduct = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.black54,
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                // SizedBox(height: 10.0),
                Text(
                  '\$${loadedProduct.amount}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  loadedProduct.title,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  child: Text(
                    loadedProduct.description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 120.0),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        decrement();
                        // print(quantity);
                      },
                      icon: Icon(Icons.remove),
                    ),
                    SizedBox(width: 10.0),
                    Text(quantity.toString()),
                    SizedBox(width: 10.0),
                    IconButton(
                      onPressed: () {
                        increment();
                        // print(quantity);
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false).addItem(
                        productId,
                        loadedProduct.title,
                        loadedProduct.amount,
                        loadedProduct.imageUrl,
                        quantity);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
