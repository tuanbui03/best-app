import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/admin/payment_page.dart';
import 'package:best/features/shop/screens/admin/size_page.dart';
import 'package:best/features/shop/screens/admin/user_page.dart';
import 'package:flutter/material.dart';

import '../../../authentication/screens/login/login.dart';
import 'brand_page.dart';
import 'category_page.dart';
import 'color_page.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: AppBar(title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Admin Page'),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => const LoginScreen()));
                  },
                  child: const Text("Logout"))
            ],
          )),
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
                    title: Text('Admin'),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.grid_view),
                  title: const Text('Brands'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BrandPage()));
                  },
                ),
                ListTile(
                    leading: const Icon(Icons.category_outlined ),
                    title: const Text('Categories'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CategoryPage()));
                    }),
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Users'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.code_sharp),
                  title: const Text('Size'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SizePage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.color_lens_outlined),
                  title: const Text('Color'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ColorPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.payment),
                  title: const Text('Payments'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentPage()));
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Divider(),
               Center(
                child: Text(
                  'Hello ${DataApp.user['user_name']}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          )),
    );
  }
}
