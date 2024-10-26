import 'package:best/api/product_api.dart';
import 'package:best/api/user_api.dart';
import 'package:best/api/wishlist_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/model/wishlist.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);
  @override
  State<WishlistPage> createState() => _PageState();
}

class _PageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Text('     Wishlist'),
                  ],
                ),
              ),
              body: const HomePage(),
            )));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List listObs = [];
  Future<List> _loadData() async {
    listObs = await WishlistAPI.getWishlistByShopID(DataApp.userShopID['id']);
    return listObs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: _loadData(),
              builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) => Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    subtitle: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "id : ${snapshot.data![index]['id']}"),
                              Text(
                                  "ProductName : ${snapshot.data![index]['product']['name']}"),
                              Text(
                                  "UserName : ${snapshot.data![index]['user']['user_name']}"),
                              Text(
                                  "Created_At : ${snapshot.data![index]['created_at']}"),
                            ],
                          ),
                        ),
                        // Column(
                        //   mainAxisAlignment:
                        //   MainAxisAlignment.spaceAround,
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     ElevatedButton(
                        //         onPressed: () async {
                        //           var ob = await WishlistAPI
                        //               .getWishlistByID(snapshot
                        //               .data![index]['id']);
                        //           await Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     FormObject(ob, 'Edit')),
                        //           );
                        //           setState(() {
                        //             build(context);
                        //           });
                        //         },
                        //         child: const Icon(Icons.edit)),
                        //     const Text('\n'),
                        //     ElevatedButton(
                        //         onPressed: () async {
                        //           await WishlistAPI
                        //               .deleteWishlistByID(snapshot
                        //               .data![index]['id']);
                        //           setState(() {});
                        //         },
                        //         child: const Icon(Icons.delete)),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              )
                  : const Center(
                // render the loading indicator
                child: CircularProgressIndicator(),
              )),
        ),
      ],
    );
  }
}


// listProduct map
Map<int, String> _mapProduct = {0: "Select Product "};

String _valueProduct = _mapProduct.entries.first.value;
List listProduct = [];

Future<List> _loadDataProduct() async {
  listProduct = await ProductAPI.getProducts();
  for (var data in listProduct) {
    Map<int, String> map = {data['id']: "${data['name']}"};
    _mapProduct.addEntries(map.entries);
  }
  return listProduct;
}

// listUser map
Map<int, String> _mapUser = {0: "Select User "};
String _valueUser = _mapUser.entries.first.value;
List listUser = [];

Future<List> _loadDataUser() async {
  listUser = await UserAPI.getUsers();
  for (var data in listUser) {
    Map<int, String> map = {data['id']: data['user_name']};
    _mapUser.addEntries(map.entries);
  }
  return listUser;
}
int colorImageID = 0;
class FormObject extends StatefulWidget {
  dynamic ob;
  dynamic title;

  FormObject(this.ob, this.title, {super.key});

  @override
  State<FormObject> createState() => _FormObject();
}

class _FormObject extends State<FormObject> {
  var productCtrl = TextEditingController();
  var userCtrl = TextEditingController();
  var title = '';

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        productCtrl.text = widget.ob['product']['id'].toString() ;
        _valueProduct = widget.ob['product']['name'] ?? '';
        userCtrl.text = widget.ob['user']['id'].toString() ;
        _valueUser = widget.ob['user']['user_name'].toString();
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title Feedback',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: _loadDataProduct(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueProduct,
                    onChanged: (newValue) {
                      setState(() {
                        _valueProduct = newValue!;
                        _mapProduct.forEach((key, value) {
                          if (_valueProduct == value) {
                            colorImageID = key;
                            productCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e
                      in _mapProduct.entries)
                        DropdownMenuItem(
                          value: e.value,
                          child: Text(e.value),
                        ),
                    ],
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: _loadDataUser(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueUser,
                    onChanged: (newValue) {
                      setState(() {
                        _valueUser = newValue!;
                        _mapUser.forEach((key, value) {
                          if (_valueUser == value) {
                            userCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e in _mapUser.entries)
                        DropdownMenuItem(
                          value: e.value,
                          child: Text(e.value),
                        ),
                    ],
                  )
                      : const Center(
                    child: CircularProgressIndicator(),
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  if (title == 'Add') {
                    var ob = Wishlist(0,int.parse(productCtrl.text),
                        int.parse(userCtrl.text), "","");
                    await WishlistAPI.addWishlist(ob);
                  } else {
                    var ob = Wishlist(widget.ob['id'],int.parse(productCtrl.text),
                        int.parse(userCtrl.text), "","");
                    await WishlistAPI.updateWishlist(ob);
                  }
                  Navigator.pop(context, productCtrl.text);
                },
                child: Text(title),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
