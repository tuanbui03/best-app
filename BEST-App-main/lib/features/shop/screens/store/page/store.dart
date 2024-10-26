import 'package:best/features/shop/screens/flowchart/flowchart_screen.dart';
import 'package:best/features/shop/screens/store/page/shop_page.dart';
import 'package:flutter/material.dart';
import 'feedback_page.dart';
import 'order/order_page.dart';
import 'product/product_page.dart';
import 'voucher_page.dart';
import 'wishlist_page.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
            appBar: AppBar(title: const Text("Shop Home")),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0xffa3eda1)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          "A",
                        ),
                      ),
                      title: Text('Shop'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment ),
                    title: const Text('Orders'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.art_track),
                    title: const Text('Products'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.assignment_returned_sharp),
                    title: const Text('Vouchers'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VoucherPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.book),
                    title: const Text('Wishlists'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WishlistPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.send_time_extension),
                    title: const Text('Feedbacks'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Setting'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShopPage()));
                    },
                  ),
                ],
              ),
            ),
            body:
            Scrollbar(
                child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: 2,
                      maxCrossAxisExtent: 500,
                    ),
                    children: const [
                  // Text('Sold in the month'),
                  Center(child: FlowChartScreen())
                ]))
        ));
  }
}
