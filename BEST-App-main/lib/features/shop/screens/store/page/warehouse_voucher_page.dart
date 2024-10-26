import 'package:best/api/voucher_api.dart';
import 'package:best/api/warehouse_voucher_api.dart';
import 'package:flutter/material.dart';
import '../../../../../api/user_api.dart';
import '../../../../../model/warehouse_voucher.dart';

class WarehouseVoucherPage extends StatefulWidget {
  const WarehouseVoucherPage({Key? key}) : super(key: key);
  @override
  State<WarehouseVoucherPage> createState() => _PageState();
}

class _PageState extends State<WarehouseVoucherPage> {
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
                    const Text('     WarehouseVoucher'),
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
    listObs = await WarehouseVoucherAPI.getWarehouseVouchers();
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
                                  "WarehouseVoucherId : ${snapshot.data![index]['id']}"),
                              Text(
                                  "UserName : ${snapshot.data![index]['user']['user_name']}"),
                              Text(
                                  "Voucher : ${snapshot.data![index]['voucher']['code']}"),

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
                                  var ob = await WarehouseVoucherAPI
                                      .getWarehouseVoucherByID(snapshot
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
                                child: Icon(Icons.edit)),
                            const Text('\n'),
                            ElevatedButton(
                                onPressed: () async {
                                  await WarehouseVoucherAPI
                                      .deleteWarehouseVoucherByID(snapshot
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


// listVoucher map
Map<int, String> _mapVoucher = {0: "Select Voucher "};
String _valueVoucher = _mapVoucher.entries.first.value;
List listVoucher = [];
Future<List> _loadDataVoucher() async {
  listVoucher = await VoucherAPI.getVouchers();
  for (var data in listVoucher) {
    Map<int, String> map = {data['id']: data['code']};
    _mapVoucher.addEntries(map.entries);
  }
  return listVoucher;
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
  var voucherCtrl = TextEditingController();
  var userCtrl = TextEditingController();
  var title = '';

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        voucherCtrl.text = widget.ob['voucher']['id'].toString() ?? '';
        _valueVoucher = widget.ob['voucher']['code'] ?? '';
        userCtrl.text = widget.ob['user']['id'].toString() ?? '';
        _valueUser = widget.ob['user']['user_name'] ?? '';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WarehouseVoucher $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title WarehouseVoucher',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: _loadDataVoucher(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? DropdownButton<String>(
                    value: _valueVoucher,
                    onChanged: (newValue) {
                      setState(() {
                        _valueVoucher = newValue!;
                        _mapVoucher.forEach((key, value) {
                          if (_valueVoucher == value) {
                            voucherCtrl.text = key.toString();
                          }
                        });
                      });
                    },
                    items: [
                      for (MapEntry<int, String> e
                      in _mapVoucher.entries)
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
                    var ob = WarehouseVoucher(0,int.parse(userCtrl.text),
                        int.parse(voucherCtrl.text));
                    await WarehouseVoucherAPI.addWarehouseVoucher(ob);
                  } else {
                    var ob =  WarehouseVoucher(widget.ob['id'],int.parse(userCtrl.text),
                        int.parse(voucherCtrl.text));
                    await WarehouseVoucherAPI.updateWarehouseVoucher(ob);
                  }
                  Navigator.pop(context, voucherCtrl.text);
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

