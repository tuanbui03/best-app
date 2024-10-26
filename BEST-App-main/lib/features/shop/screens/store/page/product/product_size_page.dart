import 'package:best/api/product_api.dart';
import 'package:best/api/product_size_api.dart';
import 'package:best/api/size_api.dart';
import 'package:best/model/product_size.dart';
import 'package:flutter/material.dart';

class ProductSizePage extends StatefulWidget {
  const ProductSizePage({Key? key}) : super(key: key);

  @override
  State<ProductSizePage> createState() => _PageState();
}

class _PageState extends State<ProductSizePage> {
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
                    const Text('     ProductSize'),
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
    listObs = await ProductSizeAPI.getProductSizes();
    return listObs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FormObject('', 'Add'),
                    ),
                  );
                  setState(() {
                    build(context);
                  });
                },
                child: const Text('Add')),
          ],
        ),
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
                                  "Id : ${snapshot.data![index]['id']}"),
                              Text(
                                  "name : ${snapshot.data![index]['product']['name']}"),
                              Text(
                                  "Size : ${snapshot.data![index]['size']['size']}"),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  var ob = await ProductSizeAPI
                                      .getProductSizeByID(snapshot
                                      .data![index]['id']);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormObject(ob, 'Edit')),
                                  );
                                  setState(() {
                                    build(context);
                                  });
                                },
                                child: const Icon(Icons.edit)),
                            const Text('\n'),
                            ElevatedButton(
                                onPressed: () async {
                                  await ProductSizeAPI
                                      .deleteProductSizeByID(snapshot
                                      .data![index]['id']);
                                  setState(() {});
                                },
                                child: const Icon(Icons.delete)),
                          ],
                        ),
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

// listSize map
Map<int, String> _mapSize = {0: "Select Size "};
String _valueSize = _mapSize.entries.first.value;
List listSize = [];

Future<List> _loadDataSize() async {
  listSize = await SizeAPI.getSizes();
  for (var data in listSize) {
    Map<int, String> map = {data['id']: data['size'].toString()};
    _mapSize.addEntries(map.entries);
  }
  return listSize;
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
  var sizeCtrl = TextEditingController();
  var title = '';

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        productCtrl.text = widget.ob['product']['id'].toString();
        _valueProduct = widget.ob['product']['name'] ?? '';
        sizeCtrl.text = widget.ob['size']['id'].toString() ;
        _valueSize = widget.ob['size']['size'].toString();
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductSize $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title ProductSize',
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
                  future: _loadDataSize(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueSize,
                    onChanged: (newValue) {
                      setState(() {
                        _valueSize = newValue!;
                        _mapSize.forEach((key, value) {
                          if (_valueSize == value) {
                            sizeCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e in _mapSize.entries)
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
                    var ob = ProductSize(0,
                        int.parse(productCtrl.text), int.parse(sizeCtrl.text));
                    await ProductSizeAPI.addProductSize(ob);
                  } else {
                    var ob = ProductSize(widget.ob['id'],
                        int.parse(productCtrl.text), int.parse(sizeCtrl.text));
                    await ProductSizeAPI.addProductSize(ob);
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
