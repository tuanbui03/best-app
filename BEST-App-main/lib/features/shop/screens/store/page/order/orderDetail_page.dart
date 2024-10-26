import 'package:best/api/order_api.dart';
import 'package:best/api/order_detail_api.dart';
import 'package:best/api/product_detail_api.dart';
import 'package:best/api/warehouse_voucher_api.dart';
import 'package:best/model/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);
  @override
  State<OrderDetailPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<OrderDetailPage> {
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
                    const Text('     OrderDetail'),
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
    listObs = await OrderDetailAPI.getOrderDetails();
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
                                  "id : ${snapshot.data![index]['id']}"),
                              Text(
                                  "order : ${snapshot.data![index]['order']['id']}"),
                              Text(
                                  "WarehouseVoucher : ${snapshot.data![index]['WarehouseVoucher']['code']}"),
                              Text(
                                  "ProductDetail : ${snapshot.data![index]['ProductDetail']['name']}"),
                              Text("Color : ${snapshot.data![index]['color']['name']}"),
                              Text("Size : ${snapshot.data![index]['size']['size']}"),
                              Text("Quantity : ${snapshot.data![index]['quantity']}"),
                              Text("Price : ${snapshot.data![index]['price']}"),
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
                                  var ob = await OrderDetailAPI
                                      .getOrderDetailByID(snapshot
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
                                  await OrderDetailAPI
                                      .deleteOrderDetailByID(snapshot
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

// listOrder map
Map<int, String> _mapOrder = {0: "Select Order "};
String _valueOrder = _mapOrder.entries.first.value;
List listOrder = [];
Future<List> _loadDataOrder() async {
  listOrder = await OrderAPI.getOrders();
  for (var data in listOrder) {
    Map<int, String> map = {data['id']: data['id'].toString()};
    _mapOrder.addEntries(map.entries);
  }
  return listOrder;
}
// listWarehouseVoucher map
Map<int, String> _mapWarehouseVoucher = {0: "Select WarehouseVoucher "};
String _valueWarehouseVoucher = _mapWarehouseVoucher.entries.first.value;
List listWarehouseVoucher = [];
Future<List> _loadDataWarehouseVoucher() async {
  listWarehouseVoucher = await WarehouseVoucherAPI.getWarehouseVouchers();
  for (var data in listWarehouseVoucher) {
    Map<int, String> map = {data['id']: data['voucher']['code']};
    _mapWarehouseVoucher.addEntries(map.entries);
  }
  return listWarehouseVoucher;
}
// listProductDetail map
Map<int, String> _mapProductDetail = {0: "Select ProductDetail "};
String _valueProductDetail = _mapProductDetail.entries.first.value;
List listProductDetail = [];
Future<List> _loadDataProductDetail() async {
  listProductDetail = await ProductDetailAPI.getProductDetails();
  for (var data in listProductDetail) {
    Map<int, String> map = {data['id']: "${data['name']}"};
    _mapProductDetail.addEntries(map.entries);
  }
  return listProductDetail;
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
  var orderCtrl = TextEditingController();
  var warehouseVoucherCtrl = TextEditingController();
  var productDetailCtrl = TextEditingController();
  var quantityCtrl = TextEditingController();
  var priceCtrl = TextEditingController();

  var title = '';

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        orderCtrl.text = widget.ob['order']['id'].toString() ;
        _valueOrder = widget.ob['order']['id'].toString() ;

        warehouseVoucherCtrl.text = widget.ob['warehouseVoucher']['id'].toString();
        _valueWarehouseVoucher = widget.ob['warehouseVoucher']['voucher']['code'] ?? '';

        productDetailCtrl.text = widget.ob['productDetail']['product']['id'].toString() ;
        _valueProductDetail = widget.ob['productDetail']['product']['name'] ?? '';
        quantityCtrl.text = widget.ob['quantity'].toString();
        priceCtrl.text = widget.ob['price'].toString();
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OrderDetail $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title OrderDetail',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: _loadDataOrder(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueOrder,
                    onChanged: (newValue) {
                      setState(() {
                        _valueOrder = newValue!;
                        _mapOrder.forEach((key, value) {
                          if (_valueOrder == value) {
                            orderCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e
                      in _mapOrder.entries)
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
                  future: _loadDataWarehouseVoucher(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueWarehouseVoucher,
                    onChanged: (newValue) {
                      setState(() {
                        _valueWarehouseVoucher = newValue!;
                        _mapWarehouseVoucher.forEach((key, value) {
                          if (_valueWarehouseVoucher == value) {
                            warehouseVoucherCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e
                      in _mapWarehouseVoucher.entries)
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
                  future: _loadDataProductDetail(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueProductDetail,
                    onChanged: (newValue) {
                      setState(() {
                        _valueProductDetail = newValue!;
                        _mapProductDetail.forEach((key, value) {
                          if (_valueProductDetail == value) {
                            productDetailCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e
                      in _mapProductDetail.entries)
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Quantity ',
                    labelText: 'Quantity',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: priceCtrl,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Price ',
                    labelText: 'Price',
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
                    var ob = OrderDetail(0,int.parse(orderCtrl.text),int.parse(warehouseVoucherCtrl.text),
                        int.parse(productDetailCtrl.text),int.parse(quantityCtrl.text),
                        double.parse(priceCtrl.text));
                    await OrderDetailAPI.addOrderDetail(ob);
                  } else {
                    var ob = OrderDetail(widget.ob['id'],int.parse(orderCtrl.text),int.parse(warehouseVoucherCtrl.text),int.parse(productDetailCtrl.text), int.parse(quantityCtrl.text),double.parse(priceCtrl.text));
                    await OrderDetailAPI.updateOrderDetail(ob);
                  }
                  Navigator.pop(context, productDetailCtrl.text);
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
