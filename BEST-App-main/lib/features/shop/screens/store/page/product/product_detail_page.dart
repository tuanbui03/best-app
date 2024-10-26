import 'package:best/api/product_api.dart';
import 'package:best/api/product_color_api.dart';
import 'package:best/api/product_detail_api.dart';
import 'package:best/api/product_size_api.dart';
import 'package:best/model/product_detail.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _PageState();
}

class _PageState extends State<ProductDetailPage> {
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
                    const Text('     ProductDetail'),
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
    listObs = await ProductDetailAPI.getProductDetails();
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
                                  "ProductName : ${snapshot.data![index]['productSize']['product']['name']}"),
                              Text(
                                  "Size : ${snapshot.data![index]['productSize']['size']['size']}"),
                              Text(
                                  "Color : ${snapshot.data![index]['productColor']['color']['name']}"),
                              Text(
                                  "Quantity : ${snapshot.data![index]['quantity']}"),
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
                                  var ob = await ProductDetailAPI
                                      .getProductDetailByID(snapshot
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
                                  await ProductDetailAPI
                                      .deleteProductDetailByID(snapshot
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
// mapColor
Map<int, String> mapColor = {0: "Select Color "};
String _valueColor = mapColor.entries.first.value;
List listColor = [];
Future<List> _loadDataColor(int id) async {
  listColor = [];
  mapColor.clear();
  Map<int, String> map = {0: "Select Color"};
  mapColor.addEntries(map.entries);
  listColor = await ProductColorAPI.getListProductColorByProductID(id);
  for (var data in listColor) {
    Map<int, String> map = {data['id']: data['color']['name']};
    mapColor.addEntries(map.entries);
  }
  return listColor;
}

// listSize map
Map<int, String> _mapSize = {0: "Select Size "};
String _valueSize = _mapSize.entries.first.value;
List listSize = [];
Future<List> _loadDataSize(int id) async {
  listSize = [];
  _mapSize.clear();
  Map<int, String> map = {0: "Select Size"};
  _mapSize.addEntries(map.entries);
  listSize = await ProductSizeAPI.getProductSizeByProductID(id);
  for (var data in listSize) {
    map = {data['id']: data['size']['size'].toString()};
    _mapSize.addEntries(map.entries);
  }
  return listSize;
}
class FormObject extends StatefulWidget {
  dynamic ob;
  dynamic title;

  FormObject(this.ob, this.title, {super.key});

  @override
  State<FormObject> createState() => _FormObject();
}

class _FormObject extends State<FormObject> {
  var productCtrl = TextEditingController();
  var colorCtrl = TextEditingController();
  var sizeCtrl = TextEditingController();
  var quantityCtrl = TextEditingController();
  int productID = 0;
  var title = '';

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        productCtrl.text = widget.ob['product']['id'].toString();
        productID =  widget.ob['product']['id'] ?? '';
        _valueProduct = widget.ob['product']['name'] ?? '';

        sizeCtrl.text = widget.ob['productSize']['id'].toString();
        _valueSize = widget.ob['productSize']['size']['size'].toString();
        colorCtrl.text = widget.ob['productColor']['id'].toString() ;
        _valueColor = widget.ob['productColor']['color']['name'].toString();
        quantityCtrl.text = widget.ob['quantity'].toString();
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductDetail $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title ProductDetail',
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
                            productID = key;
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
                  future: _loadDataColor(productID),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueColor,
                    onChanged: (newValue) {
                      setState(() {
                        _valueColor = newValue!;
                        mapColor.forEach((key, value) {
                          if (_valueColor == value) {
                            colorCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e
                      in mapColor.entries)
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
                  future: _loadDataSize(productID),
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
                      for (MapEntry<int, String> e
                      in _mapSize.entries)
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
              TextField(
                  controller: quantityCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'quantity',
                    labelText: 'Quantity',
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
                    var ob = ProductDetail(0, int.parse(sizeCtrl.text), int.parse(colorCtrl.text), int.parse(quantityCtrl.text));
                    await ProductDetailAPI.addProductDetail(ob);
                  } else {
                    var ob = ProductDetail(widget.ob['id'], int.parse(sizeCtrl.text), int.parse(colorCtrl.text), int.parse(quantityCtrl.text));
                    await ProductDetailAPI.updateProductDetail(ob);
                  }
                  Navigator.pop(context, productCtrl.text);
                },
                child: Text(title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
