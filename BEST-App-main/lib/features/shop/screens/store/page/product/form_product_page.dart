import 'package:best/api/brand_api.dart';
import 'package:best/api/category_api.dart';
import 'package:best/api/product_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/store/page/product/form_specification_product.dart';
import 'package:best/model/product.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

Map<int, String> _mapBrand = {0: "Select Brand"};
String _valueBrand = _mapBrand.entries.first.value;
List listBrand = [];

Future<List> _loadDataBrand() async {
  listBrand = await BrandAPI.getBrands();
  for (var data in listBrand) {
    Map<int, String> map = {data['id']: data['name']};
    _mapBrand.addEntries(map.entries);
  }
  return listBrand;
}

// listCategory map
Map<int, String> _mapCategory = {0: "Select Category "};
String _valueCategory = _mapCategory.entries.first.value;
List listCategory = [];

Future<List> _loadDataCategory() async {
  listCategory = await CategoryAPI.getAllCategory();
  for (var data in listCategory) {
    Map<int, String> map = {data['id']: data['name']};
    _mapCategory.addEntries(map.entries);
  }
  return listCategory;
}

class FormProduct extends StatefulWidget {
  dynamic ob;
  dynamic title;

  FormProduct(this.ob, this.title, {super.key});

  @override
  State<FormProduct> createState() => _FormObject();
}

enum Status { disAction, action }

class _FormObject extends State<FormProduct> {
  var brandCtrl = TextEditingController();
  var categoryCtrl = TextEditingController();
  var productCtrl = TextEditingController();
  var quantityCtrl = TextEditingController();
  var priceCtrl = TextEditingController();
  var descriptionCtrl = TextEditingController();
  var codeCtrl = TextEditingController();
  var discountCtrl = TextEditingController();
  var statusCtrl = TextEditingController();
  var title = '';
  Status? _status = Status.disAction;

  @override
  void initState() {
    setState(() {
      if (widget.ob != '') {
        brandCtrl.text = widget.ob['brand']['id'].toString();
        _valueBrand = widget.ob['brand']['name'] ?? '';
        categoryCtrl.text = widget.ob['category']['id'].toString();
        _valueCategory = widget.ob['category']['name'] ?? '';
        productCtrl.text = widget.ob['name'] ?? '';
        quantityCtrl.text = widget.ob['quantity'].toString();
        priceCtrl.text = widget.ob['price'].toString();
        descriptionCtrl.text = widget.ob['description'] ?? '';
        codeCtrl.text = widget.ob['code'] ?? '';
        discountCtrl.text = widget.ob['discount'].toString();
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
        title: Text('$title Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Align(alignment: Alignment.center,child: Text('Basic information',
                  style: Theme.of(context).textTheme.headlineMedium),),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FutureBuilder(
                      future: _loadDataBrand(),
                      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? DropdownButton<String>(
                        value: _valueBrand,
                        onChanged: (newValue) {
                          setState(() {
                            _valueBrand = newValue!;
                            _mapBrand.forEach((key, value) {
                              if (_valueBrand == value) {
                                brandCtrl.text = key.toString();
                              }
                            });
                          });
                        },
                        items: [
                          for (MapEntry<int, String> e
                          in _mapBrand.entries)
                            DropdownMenuItem(
                              value: e.value,
                              child: Text(e.value),
                            ),
                        ],
                      )
                          : const Center(
                        child: CircularProgressIndicator(),
                      )),
                  FutureBuilder(
                      future: _loadDataCategory(),
                      builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? DropdownButton<String>(
                        value: _valueCategory,
                        onChanged: (newValue) {
                          setState(() {
                            _valueCategory = newValue!;
                            _mapCategory.forEach((key, value) {
                              if (_valueCategory == value) {
                                categoryCtrl.text = key.toString();
                              }
                            });
                          });
                        },
                        items: [
                          for (MapEntry<int, String> e
                          in _mapCategory.entries)
                            DropdownMenuItem(
                              value: e.value,
                              child: Text(e.value),
                            ),
                        ],
                      )
                          : const Center(
                        child: CircularProgressIndicator(),
                      )),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                  controller: productCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Name',
                    labelText: 'Product Name',
                  )),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller: quantityCtrl,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: ' Quantity',
                          labelText: 'Quantity',
                        )),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: TextField(
                        controller: priceCtrl,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '123\$',
                          labelText: 'Price',
                        )),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                  controller: descriptionCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Text ',
                    labelText: 'Description',
                  )),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                  controller: codeCtrl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Code',
                    labelText: 'Code',
                  )),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextField(
                  controller: discountCtrl,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (text) {
                    if (int.parse(text) > 100) {
                      discountCtrl.text = '0';
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' 12%',
                    labelText: 'Discount',
                  )),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              const Text('Status'),
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
                  bool result = false;
                  if (title == 'Add') {
                    var product = Product(
                        0,
                        int.parse(brandCtrl.text),
                        int.parse(categoryCtrl.text),
                        DataApp.userShopID['id'],
                        productCtrl.text,
                        int.parse(quantityCtrl.text),
                        double.parse(priceCtrl.text),
                        descriptionCtrl.text,
                        codeCtrl.text,
                        int.parse(discountCtrl.text),
                        0,
                        '',
                        int.parse(statusCtrl.text));
                    result = await ProductAPI.addProduct(product);
                  } else {
                    var product = Product(
                        widget.ob['id'],
                        int.parse(brandCtrl.text),
                        int.parse(categoryCtrl.text),
                        DataApp.userShopID['id'],
                        productCtrl.text,
                        int.parse(quantityCtrl.text),
                        double.parse(priceCtrl.text),
                        descriptionCtrl.text,
                        codeCtrl.text,
                        int.parse(discountCtrl.text),
                        0,
                        '',
                        int.parse(statusCtrl.text));
                    result = await ProductAPI.updateProduct(product);
                  }
                  if(result == true) {
                    dynamic ob = await ProductAPI.getProductByShopID(DataApp.user['id']);
                    Navigator.push(context,MaterialPageRoute(builder: (builder)=> FormSpecificationProduct('Add',ob[ob.length-1])));
                  }
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
