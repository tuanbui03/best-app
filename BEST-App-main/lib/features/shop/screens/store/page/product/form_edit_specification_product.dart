import 'package:best/api/color_api.dart';
import 'package:best/api/product_color_api.dart';
import 'package:best/api/product_detail_api.dart';
import 'package:best/api/product_size_api.dart';
import 'package:best/api/size_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/store/page/product/product_page.dart';
import 'package:best/features/shop/screens/store/page/product/text_field_image.dart';
import 'package:best/features/shop/screens/store/page/product/text_field_quantity.dart';
import 'package:best/model/product_color.dart';
import 'package:best/model/product_detail.dart';
import 'package:best/model/product_size.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormEditSpecificationProduct extends StatefulWidget {
  dynamic title;
  dynamic product;
  FormEditSpecificationProduct(this.title, this.product, {super.key});
  @override
  State<FormEditSpecificationProduct> createState() =>
      _FormSpecificationProductState();
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

// mapColor
Map<int, String> mapColor = {0: "Select Color "};
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

class _FormSpecificationProductState extends State<FormEditSpecificationProduct> {
  Map<int, String> mapDataProductColor = {};
  Map<int, String> mapDataProductImage = {};
  Map<int, int> mapDataProductSize = {};
  bool stateLoad = true;
  List listColor = [];
  List listSize = [];
  List listDataProductDetail = [];
  Future<List> _loadData() async {
    if(stateLoad) {
      listColor = await ProductColorAPI.getListProductColorByProductID(
          widget.product['id']);
      for (var data in listColor) {
        Map<int, String> map = {data['id']: data['color']['name']};
        mapDataProductColor.addEntries(map.entries);
        Map<int, String> mapImage = {data['id']: data['image']};
        mapDataProductImage.addEntries(mapImage.entries);
      }
      listSize =
      await ProductSizeAPI.getProductSizeByProductID(widget.product['id']);
      for (var data in listSize) {
        Map<int, int> map = {data['id']: data['size']['size']};
        mapDataProductSize.addEntries(map.entries);
      }
      listDataProductDetail =
      await ProductDetailAPI.getProductDetailByShopIDAndProductID(
          DataApp.userShopID['id'], widget.product['id']);
      stateLoad = false;
    }
    return listColor;
  }
  @override
  Widget build(BuildContext context) {
    DataApp.indexQuantityProduct = 0;
    DataApp.indexImageProduct = 0;
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title} Product Attribute'),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child:
              FutureBuilder(
              future: _loadData(),
              builder:
              (BuildContext ctx,
              AsyncSnapshot<List>
              snapshots) =>
              snapshots.hasData
              ?
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text('Product Name : ${widget.product['name']}',style: TextStyle(color: Colors.blue),
                              )),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Specification',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              subtitle: Column(children: [
                                  Row(
                                    children: [
                                      Text('Color'),
                                      Row(
                                        children: [
                                          for (var map
                                              in mapDataProductColor.entries)
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text(map.value))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  FutureBuilder(
                                      future: _loadDataColor(),
                                      builder: (BuildContext ctx,
                                              AsyncSnapshot<List> snapshot) =>
                                          snapshot.hasData
                                              ? DropdownButton<String>(
                                                  value: _valueColor,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _valueColor = newValue!;
                                                      mapColor.forEach(
                                                          (key, value) {
                                                        if (_valueColor ==
                                                            value) {
                                                          Map<int, String>
                                                              mapData = {
                                                            key: value
                                                          };
                                                          mapDataProductColor
                                                              .addEntries(
                                                                  mapData
                                                                      .entries);
                                                          setState(() {});
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
                                                  child:
                                                      CircularProgressIndicator(),
                                                )),
                                ]))
                          ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              subtitle: Column(children: [
                                  Row(
                                    children: [
                                      Text('Size'),
                                      Row(
                                        children: [
                                          for (var map
                                              in mapDataProductSize.entries)
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text('${map.value}'))
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  FutureBuilder(
                                      future: _loadDataSize(),
                                      builder: (BuildContext ctx,
                                              AsyncSnapshot<List> snapshot) =>
                                          snapshot.hasData
                                              ? DropdownButton<String>(
                                                  value: _valueSize,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      _valueSize = newValue!;
                                                      _mapSize.forEach(
                                                          (key, value) {
                                                        if (_valueSize ==
                                                            value) {
                                                          Map<int, int>
                                                              mapData = {
                                                            key:
                                                                int.parse(value)
                                                          };
                                                          mapDataProductSize
                                                              .addEntries(
                                                                  mapData
                                                                      .entries);
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
                                                  child:
                                                      CircularProgressIndicator(),
                                                )),
                                ]))
                         ),
                      Table(
                          border: TableBorder.all(),
                          children: const [
                            TableRow(children: [
                              Text('Color'),
                              Text('Size'),
                              Text('Quantity'),
                            ]),
                          ]),
                      Table(
                          children: [
                            for (var mapColor in mapDataProductColor.entries)
                              TableRow(children: [
                                Table(border: TableBorder.all(), children: [
                                  TableRow(children: [
                                    for(var mapImage in mapDataProductImage.entries)
                                      if(mapColor.key == mapImage.key)
                                        TextFieldImage(mapColor.value,mapImage.value),
                                    Table(border: TableBorder.all(), children:  [
                                      for (var mapSize in mapDataProductSize.entries)
                                        TableRow(children: [
                                          Text('${mapSize.value}'),
                                        ]),
                                    ]),
                                    Table(border: TableBorder.all(), children:  [
                                      for (var mapSize in mapDataProductSize.entries)
                                        for(int data = 0; data < listDataProductDetail.length; data++)
                                          if(mapColor.key == listDataProductDetail[data]['productColor']['id'] &&
                                              mapSize.key == listDataProductDetail[data]['productSize']['id'])
                                            TableRow(children: [
                                              Text('${listDataProductDetail[data]['quantity']}')
                                              // TextFieldQuantity(listDataProductDetail[data]['quantity'])
                                        ]),
                                    ]),
                                  ]),
                                ]),
                              ]),
                          ]),
                      ElevatedButton(onPressed: ()async{
                        List<int> listProductColorID = [];
                        List<int> listProductSizeID = [];
                        int indexColor = -1;
                        for (var mapColor in mapDataProductColor.entries){
                          indexColor++;
                          ProductColor productColor = ProductColor(0,widget.product['id'],mapColor.key,DataApp.listImageProduct[indexColor]);
                          await ProductColorAPI.addProductColor(productColor);
                          dynamic ob = await ProductColorAPI.getListProductColorByProductIdAndColorID(widget.product['id'], mapColor.key);
                          listProductColorID.add(ob[0]['id']);
                        }
                        for (var mapSize in mapDataProductSize.entries){
                          ProductSize productSize = ProductSize(0, widget.product['id'], mapSize.key);
                          await ProductSizeAPI.addProductSize(productSize);
                          dynamic ob = await ProductSizeAPI.getProductSizeByProductIdAndSizeID(widget.product['id'], mapSize.key);
                          listProductSizeID.add(ob[0]['id']);
                        }
                        int indexQuantity = 0;
                        for( int i = 0; i < listProductColorID.length; i++){
                          for(int j = 0; j < listProductSizeID.length; j++){
                            ProductDetail productDetail = ProductDetail(0, listProductSizeID[j], listProductColorID[i], DataApp.listQuantityProduct[indexQuantity]);
                            await ProductDetailAPI.addProductDetail(productDetail);
                            indexQuantity++;
                          }
                        }
                        Get.offAll(() =>const ProductPage());
                      }, child: Text('Save'))
                    ]):Text(''),
    ),)));
  }
}
