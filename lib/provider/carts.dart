import 'package:flutter/material.dart';
import 'package:shop_app/provider/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, double price, String imageUrl,
      int quantity) {
    if (_items.containsKey(productId)) {
      //if the specific item exist then we increase the quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          imageUrl: existingCartItem.imageUrl,
          price: existingCartItem.price,
          quantity: quantity,
        ),
      );
    } else {
      //if the specificitem is not in cart yet, so we add
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          imageUrl: imageUrl,
          price: price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }
  // void addItem(String productId, String title, double price, String imageUrl) {
  //   if (_items.containsKey(productId)) {
  //     //if the specific item exist then we increase the quantity
  //     _items.update(
  //       productId,
  //       (existingCartItem) => CartItem(
  //         id: existingCartItem.id,
  //         title: existingCartItem.title,
  //         imageUrl: existingCartItem.imageUrl,
  //         price: existingCartItem.price,
  //         quantity: existingCartItem.quantity + 1,
  //       ),
  //     );
  //   } else {
  //     //if the specificitem is not in cart yet, so we add
  //     _items.putIfAbsent(
  //       productId,
  //       () => CartItem(
  //         id: DateTime.now().toString(),
  //         title: title,
  //         imageUrl: imageUrl,
  //         price: price,
  //         quantity: 1,
  //       ),
  //     );
  //   }
  //   notifyListeners();
  // }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCartAfterOrder() {
    _items = {};
    notifyListeners();
  }
}
