import 'package:best/api/product_api.dart';
import 'package:best/api/voucher_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/model/voucher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({Key? key}) : super(key: key);

  @override
  State<VoucherPage> createState() => _PageState();
}

class _PageState extends State<VoucherPage> {
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
                    const Text('     Voucher'),
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
    listObs = await VoucherAPI.getVoucherByShopID(DataApp.userShopID['id']);
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
                                  "VoucherCode : ${snapshot.data![index]['code']}"),
                              Text(
                                  "DiscountPercent : ${snapshot.data![index]['discount_percent']}"),
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
                                  await VoucherAPI.getVoucherByID(
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
                                  await VoucherAPI.deleteVoucherByID(
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
                  : const Text(''))
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
  listProduct = await ProductAPI.getProductByShopID(DataApp.userShopID['id']);
  for (var data in listProduct) {
    Map<int, String> map = {data['id']: "${data['name']}"};
    _mapProduct.addEntries(map.entries);
  }
  return listProduct;
}


class FormObject extends StatefulWidget {
  dynamic ob;
  dynamic title;

  FormObject(this.ob, this.title, {super.key});

  @override
  State<FormObject> createState() => _FormObject();
}

class _FormObject extends State<FormObject> {
  var voucherCodeCtrl = TextEditingController();
  var productCtrl = TextEditingController();
  var dayStartCtrl = TextEditingController();
  var dayEndCtrl = TextEditingController();
  var discountPercentCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();
  var title = '';

  //date Start
  DateTime selectedDateStart = DateTime.now();

  Future<void> _selectDateStart(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateStart,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateStart) {
      setState(() {
        selectedDateStart = picked;
        dayStartCtrl.text = "${selectedDateStart.toLocal()}".split(' ')[0];
      });
    }
  }

  //date End
  DateTime selectedDateEnd = DateTime.now();
  Future<void> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateEnd,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateEnd) {
      setState(() {
        selectedDateEnd = picked;
        dayEndCtrl.text = "${selectedDateEnd.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        voucherCodeCtrl.text = widget.ob['code'] ?? '';
        productCtrl.text = widget.ob['product']['id'].toString();
        _valueProduct = widget.ob['product']['name'] ?? '';
        dayStartCtrl.text = widget.ob['date_start'] ?? '';
        selectedDateStart = DateTime.parse(widget.ob['date_start']);
        dayEndCtrl.text = widget.ob['date_end'] ?? '';
        selectedDateEnd = DateTime.parse(widget.ob['date_end']);
        discountPercentCtrl.text =
            widget.ob['discount_percent'].toString();
        descriptionCtrl.text = widget.ob['description'] ?? '';
      }
      title = widget.title;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher $title'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title Voucher',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: voucherCodeCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'VoucherCode',
                  )),
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
              TextField(
                  controller: dayStartCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'DayStart',
                  )),
              ElevatedButton(
                onPressed: () => _selectDateStart(context),
                child: const Text('Select date_start'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: dayEndCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'DayEnd',
                  )),
              ElevatedButton(
                onPressed: () => _selectDateEnd(context),
                child: const Text('Select date_end'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: discountPercentCtrl,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'Discount Percent',
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: descriptionCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Description',
                    labelText: 'Description',
                  )),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.teal,
                    textStyle: const TextStyle(fontSize: 15)),
                onPressed: () async {
                  if (title == 'Add') {
                    var voucher = Voucher(
                        0,
                        voucherCodeCtrl.text,
                        DataApp.userShopID['id'],
                        int.parse(productCtrl.text),
                        dayStartCtrl.text,
                        dayEndCtrl.text,
                        int.parse(discountPercentCtrl.text),
                        descriptionCtrl.text);
                    await VoucherAPI.addVoucher(voucher);
                  } else {
                    var voucher = Voucher(
                        widget.ob['id'],
                        voucherCodeCtrl.text,
                        DataApp.userShopID['id'],
                        int.parse(productCtrl.text),
                        dayStartCtrl.text,
                        dayEndCtrl.text,
                        int.parse(discountPercentCtrl.text),
                        descriptionCtrl.text);
                    await VoucherAPI.updateVoucher(voucher);
                  }
                  Navigator.pop(context, voucherCodeCtrl.text);
                },
                child: Text(widget.title),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
