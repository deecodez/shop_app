import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/orders.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item_widget.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _ordersFuture;

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchOrder();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrderFuture();
    super.initState();
  }
  // var _isInit = true;
  // var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Orders>(context, listen: false).fetchOrder().then((_) {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _ordersFuture,
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (dataSnapShot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<Orders>(
              builder: (ctx, orderData, child) => orderData.orders.isEmpty
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
        },
      ),
    );
  }
}


// orderData.orders.isEmpty
//           ? Center(
//               child: Text(
//                 'No Order yet',
//                 style: TextStyle(
//                   fontSize: 30.0,
//                 ),
//               ),
//             )
//           : _isLoading
//               ? Center(child: CircularProgressIndicator())
//               : ListView.builder(
//                   itemCount: orderData.orders.length,
//                   itemBuilder: (ctx, i) => OrderItemWidget(
//                     orderData.orders[i],
//                   ),
//                 ),