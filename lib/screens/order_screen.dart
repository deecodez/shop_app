import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item_widget.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('order'),
      ),
      drawer: AppDrawer(),
      body: orderData.orders.isEmpty
          ? Center(
              child: Text(
                'No Order yet',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) => OrderItemWidget(
                orderData.orders[i],
              ),
            ),
    );
  }
}
