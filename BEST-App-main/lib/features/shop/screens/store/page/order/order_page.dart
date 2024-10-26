import 'package:best/api/order_api.dart';
import 'package:best/api/order_detail_api.dart';
import 'package:best/api/payment_api.dart';
import 'package:best/api/user_api.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _PageState();
}

class _PageState extends State<OrderPage> {
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
                const Text('     Order'),
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
double getTotalMoney(final dataOb){
  double totalMoney = 0;
  for(final data in dataOb){
    totalMoney += data['quantity'] * data['price'] *(100 -data['warehouseVoucher']['voucher']['discount_percent'])/100;
  }
  return totalMoney;
}

class _HomePageState extends State<HomePage> {
  List listObs = [];
  List listProductCart = [];
  Future<List> _loadData() async {
    listObs = await OrderAPI.getOrderByShopID(DataApp.user['id']);
    return listObs;
  }

  //
  Future<List> _loadDataProductCart(int orderID) async {
    listProductCart = await OrderDetailAPI.getOrderDetailByShopIDAndOrderID(
        DataApp.user['id'], orderID);
    return listProductCart;
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
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                  "${snapshot.data![index]['id']} \nUser : ${snapshot.data![index]['user']['user_name']}"),
                                            ),
                                            // Expanded(
                                            //   flex: 1,
                                            //   child: ElevatedButton(
                                            //       onPressed: () async {
                                            //         var ob = await OrderAPI
                                            //             .getOrderByID(snapshot
                                            //                     .data![index]
                                            //                 ['id']);
                                            //         await Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //               builder: (context) =>
                                            //                   FormObject(
                                            //                       ob, 'Edit')),
                                            //         );
                                            //         setState(() {
                                            //           build(context);
                                            //         });
                                            //       },
                                            //       child:
                                            //           const Icon(Icons.edit)),
                                            // ),
                                          ],
                                        ),
                                        Text(
                                            "Payment : ${snapshot.data![index]['payment']['name']}"),
                                        Text(
                                            "Address : ${snapshot.data![index]['address']}"),
                                        Text(
                                            "Phone : ${snapshot.data![index]['phone']}"),
                                        Text(
                                            "Created_At : ${snapshot.data![index]['created_at']}"),
                                        FutureBuilder(
                                            future: _loadDataProductCart(
                                                snapshot.data![index]['id']),
                                            builder: (BuildContext ctx,
                                                    AsyncSnapshot<List>
                                                        snapshots) =>
                                                snapshots.hasData
                                                    ? Column(
                                                        children: [
                                                          for (int i = 0;
                                                              i <
                                                                  snapshots
                                                                      .data!
                                                                      .length;
                                                              i++)
                                                            Column(
                                                              children: [
                                                                Table(
                                                                    border:
                                                                        TableBorder
                                                                            .all(),
                                                                    defaultVerticalAlignment:
                                                                        TableCellVerticalAlignment
                                                                            .middle,
                                                                    children: [
                                                                      if(i == 0||
                                                                          i > 0 && snapshots.data![i-1]['productDetail']['productSize']['product']['id'] != snapshots.data![i]['productDetail']['productSize']['product']['id'])
                                                                        TableRow(
                                                                          children: [
                                                                            Center(
                                                                              child: Column(
                                                                                children: [
                                                                                  if(i > 0)Text("Voucher :${(snapshots.data![i-1]['warehouseVoucher']['voucher']['discount_percent']==0)?'null':' -${snapshots.data![i-1]['warehouseVoucher']['voucher']['discount_percent']}%'}"),
                                                                                  Text(
                                                                                      '${snapshots.data![i]['productDetail']['productSize']['product']['name']}', style: TextStyle(fontSize: 18),),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      if(i == 0||
                                                                          i > 0 && snapshots.data![i-1]['productDetail']['productSize']['product']['id'] != snapshots.data![i]['productDetail']['productSize']['product']['id'])
                                                                      TableRow(children: [
                                                                        Table(
                                                                          border: TableBorder.all(),
                                                                          children: const [
                                                                            TableRow(
                                                                              children: [
                                                                                Text('Color'),
                                                                                Text('Size'),
                                                                                Text('Quantity'),
                                                                                Text('Price'),
                                                                                Text('Total Money'),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ]),
                                                                      TableRow(children: [
                                                                        Table(
                                                                          border: TableBorder.all(),
                                                                          children: [
                                                                            TableRow(
                                                                              children: [
                                                                                Text( '${snapshots.data![i]['productDetail']['productColor']['color']['name']}'),
                                                                                Text( '${snapshots.data![i]['productDetail']['productSize']['size']['size']}'),
                                                                                Text('${snapshots.data![i]['quantity']}'),
                                                                                Text('\$${snapshots.data![i]['price']}'),
                                                                                Text('${(snapshots.data![i]['quantity'] * snapshots.data![i]['price']).toStringAsFixed(3)}'),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        ]),
                                                                    ]),
                                                                if(i == snapshots.data!.length -1)
                                                                Column(
                                                                  children: [
                                                                    Text("Voucher :${(snapshots.data![i]['warehouseVoucher']['voucher']['discount_percent']==0)?'null':' -${snapshots.data![i]['warehouseVoucher']['voucher']['discount_percent']}%'}"),
                                                                    const Divider(),
                                                                    Text(
                                                                      'Total : \$${getTotalMoney(snapshots.data).toStringAsFixed(3)}',)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                        ],
                                                      )
                                                    // Text('${snapshots.data![index]['productDetail']['productSize']['product']['name']}'))
                                                    : const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )),
                                      ],
                                    ),
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

// listPayment map
Map<int, String> _mapPayment = {0: "Select Payment "};

String _valuePayment = _mapPayment.entries.first.value;
List listPayment = [];

Future<List> _loadDataPayment() async {
  listPayment = await PaymentAPI.getPayments();
  for (var data in listPayment) {
    Map<int, String> map = {data['id']: "${data['name']}"};
    _mapPayment.addEntries(map.entries);
  }
  return listPayment;
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

enum Status { disAction, action }

class _FormObject extends State<FormObject> {
  var paymentCtrl = TextEditingController();
  var userCtrl = TextEditingController();
  var addressCtrl = TextEditingController();
  var totalCtrl = TextEditingController();
  var phoneCtrl = TextEditingController();
  var statusCtrl = TextEditingController();
  var title = '';
  Status? _status = Status.disAction;

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        paymentCtrl.text = widget.ob['payment']['id'].toString();
        _valuePayment = widget.ob['payment']['name'] ?? '';
        userCtrl.text = widget.ob['user']['id'].toString();
        _valueUser = widget.ob['user']['user_name'].toString();
        addressCtrl.text = widget.ob['address'] ?? '';
        totalCtrl.text = widget.ob['total'].toString();
        phoneCtrl.text = widget.ob['phone'] ?? '';
        statusCtrl.text = widget.ob['status'].toString();
        (widget.ob['status'] == 1)
            ? _status = Status.action
            : _status = Status.disAction;
      } else {
        statusCtrl.text = '0';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order $title'),
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
                  future: _loadDataPayment(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? DropdownButton<String>(
                              value: _valuePayment,
                              onChanged: (newValue) {
                                setState(() {
                                  _valuePayment = newValue!;
                                  _mapPayment.forEach((key, value) {
                                    if (_valuePayment == value) {
                                      colorImageID = key;
                                      paymentCtrl.text = key.toString();
                                    }
                                  });
                                });
                              },
                              items: [
                                for (MapEntry<int, String> e
                                    in _mapPayment.entries)
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
                                for (MapEntry<int, String> e
                                    in _mapUser.entries)
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
                  controller: addressCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address ',
                    labelText: 'Address',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: totalCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Total',
                    labelText: 'Total',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone',
                    labelText: 'Phone',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: const Text("DisAction"),
                      trailing: Radio(
                        value: Status.disAction,
                        groupValue: _status,
                        onChanged: (Status? value) {
                          setState(() {
                            _status = value;
                            statusCtrl.text = '0';
                          });
                        },
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: const Text("Action"),
                      trailing: Radio(
                        value: Status.action,
                        groupValue: _status,
                        onChanged: (Status? value) {
                          setState(() {
                            _status = value;
                            statusCtrl.text = '1';
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  if (title == 'Add') {
                    var ob = Order(
                        0,
                        int.parse(userCtrl.text),
                        int.parse(paymentCtrl.text),
                        addressCtrl.text,
                        double.parse(totalCtrl.text),
                        "",
                        phoneCtrl.text,
                        int.parse(statusCtrl.text));
                    await OrderAPI.addOrder(ob);
                  } else {
                    var ob = Order(
                        widget.ob['id'],
                        int.parse(userCtrl.text),
                        int.parse(paymentCtrl.text),
                        addressCtrl.text,
                        double.parse(totalCtrl.text),
                        "",
                        phoneCtrl.text,
                        int.parse(statusCtrl.text));
                    await OrderAPI.updateOrder(ob);
                  }
                  Navigator.pop(context, paymentCtrl.text);
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
