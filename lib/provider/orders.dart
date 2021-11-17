import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/provider/order_item.dart';

import 'cart_item.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  //Add to order to server
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    var url = Uri.parse(
        'https://myshopapp-cfd09-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timeStamp = DateTime.now();
    try {
      var response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timeStamp,
        ),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchOrder() async {
    var url = Uri.parse(
        'https://myshopapp-cfd09-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final List<OrderItem> fetchedOrder = [];
      var extractedData = json.decode(response.body) as Map<String, dynamic>;

//To fixed the issue of when server return null here and in product too
      if (extractedData == {}) {
        return;
      }
      // print(extractedData);
      extractedData.forEach((orderId, ordersData) {
        fetchedOrder.add(
          OrderItem(
            id: orderId,
            amount: ordersData['amount'],
            dateTime: DateTime.parse(ordersData['dateTime']),
            products: (ordersData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    price: item['price'],
                    quantity: item['quantity'],
                    imageUrl: item['id'],
                  ),
                )
                .toList(),
          ),
        );
      });
      // _orders = fetchedOrder;
      //To reversed by recent order
      _orders = fetchedOrder.reversed.toList();
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
