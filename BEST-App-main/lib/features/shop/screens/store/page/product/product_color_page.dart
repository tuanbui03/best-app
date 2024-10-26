import 'package:best/api/color_api.dart';
import 'package:best/api/product_api.dart';
import 'package:best/api/product_color_api.dart';
import 'package:best/model/product_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProductColorPage extends StatefulWidget {
  const ProductColorPage({Key? key}) : super(key: key);

  @override
  State<ProductColorPage> createState() => _PageState();
}

class _PageState extends State<ProductColorPage> {
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
                    const Text('     ProductColor'),
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
    listObs = await ProductColorAPI.getProductColors();
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
                                  "ID : ${snapshot.data![index]['id']}"),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                        "ProductName : ${snapshot.data![index]['product']['name']}"),
                                  ),
                                  // Expanded(
                                  //   flex: 1,
                                  //   child: Container(
                                  //     height: 90,
                                  //     width: 90,
                                  //     child: TRoundedImage(
                                  //         imageUrl:
                                  //         "${snapshot.data![index]['images']}",
                                  //         applyImageRadius: true),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Text(
                                  "ColorName : ${snapshot.data![index]['color']['name']}"),
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
                                  var ob =
                                  await ProductColorAPI.getProductColorByID(
                                      snapshot.data![index]
                                      ['id']);
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
                                  await ProductColorAPI.deleteProductColorByID(
                                      snapshot.data![index]
                                      ['id']);
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
//
Map<int, String> _map = {0: "Select "};
String _value = _map.entries.first.value;
List listProduct = [];

Future<List> _loadData() async {
  listProduct = await ProductAPI.getProducts();
  for (var data in listProduct) {
    Map<int, String> map = {data['id']: data['name']};
    _map.addEntries(map.entries);
  }
  return listProduct;
}

// mapColor
Map<int, String> mapColor = {0: "Select "};
String _valueColor = mapColor.entries.first.value;
List listColor = [];

Future<List> _loadDataColor() async {
  listColor = await ColorAPI.getColors();
  for (var data in listColor) {
    Map<int, String> map = {data['id']: data['name']};
    mapColor.addEntries(map.entries);
  }
  return listColor;
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
  var imageCtrl = TextEditingController();
  var title = '';

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    imageCtrl.text = 'assets/images/products/${result.files.first.name}';
  }

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        _value = widget.ob['product']['name'].toString() ;
        _valueColor = widget.ob['color']['name'].toString();
        productCtrl.text = widget.ob['product']['id'].toString();
        colorCtrl.text = widget.ob['color']['id'].toString();
        imageCtrl.text = widget.ob['image'] ?? '';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductColor $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title ProductColor',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: _loadData(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _value,
                    onChanged: (newValue) {
                      setState(() {
                        _value = newValue!;
                        _map.forEach((key, value) {
                          if (_value == value) {
                            productCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e in _map.entries)
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
                  future: _loadDataColor(),
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
                      for (MapEntry<int, String> e in mapColor.entries)
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
                  controller: imageCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Images',
                    labelText: 'Images',
                  )),
              MaterialButton(
                onPressed: () {
                  _pickFile();
                },
                color: Colors.green,
                child: const Text(
                  'Pick and open file',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  if (title == 'Add') {
                    var ob =
                    ProductColor(0, int.parse(productCtrl.text),int.parse(colorCtrl.text), imageCtrl.text);
                    await ProductColorAPI.addProductColor(ob);
                  } else {
                    var ob =
                    ProductColor(widget.ob['id'], int.parse(productCtrl.text),int.parse(colorCtrl.text), imageCtrl.text);
                    await ProductColorAPI.updateProductColor(ob);
                  }
                  Navigator.pop(context, productCtrl.text);
                },
                child: const Text('Update'),
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
