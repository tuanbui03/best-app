import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/features/shop/screens/order/widgets/orders_list.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key ? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar
      appBar: TAppBar(title: Text('My Orders', style: Theme.of(context).textTheme.headlineMedium)),
      body: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
        /// Orders
        child: TOrderListItems(),
      ),
    );
  }
}