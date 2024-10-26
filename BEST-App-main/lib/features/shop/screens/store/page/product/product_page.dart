import 'package:best/api/product_api.dart';
import 'package:best/api/product_color_api.dart';
import 'package:best/api/product_detail_api.dart';
import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/store/page/product/form_edit_specification_product.dart';
import 'package:best/features/shop/screens/store/page/product/form_product_page.dart';
import 'package:best/features/shop/screens/store/page/product/form_specification_product.dart';
import 'package:best/features/shop/screens/store/page/product/product_sub_page.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _PageState();
}

class _PageState extends State<ProductPage> {
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
                const Text('     Product'),
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
  List listImage = [];

  Future<List> _loadDataImage(int id) async {
    listImage = await ProductColorAPI.getListProductColorByProductID(id);
    return listImage;
  }

  Future<List> _loadData() async {
    listObs = await ProductDetailAPI.getProductDetailByShopID(
        DataApp.userShopID['id']);
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
                      builder: (context) => FormProduct('', 'Add'),
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
                      ?
                  SingleChildScrollView(
                        child:
                        Column(
                            children: [
                              for (int i = 0; i < listObs.length; i++)
                                if(i == 0 || listObs.length > 1 && listObs[i-1]['productColor']['product']['id'] != listObs[i]['productColor']['product']['id'])
                                Card(
                                  margin: const EdgeInsets.all(10),
                                  child: ListTile(
                                    subtitle: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            children: [
                                              Center(
                                                  child: Text(
                                                ' ${listObs[i]['productColor']['product']['name']}',
                                                style:
                                                    const TextStyle(fontSize: 15),
                                              )),
                                              FutureBuilder(
                                                  future: _loadDataImage(
                                                      listObs[i]['productColor']
                                                          ['product']['id']),
                                                  builder:
                                                      (BuildContext ctx,
                                                              AsyncSnapshot<List>
                                                                  snapshots) =>
                                                          snapshots.hasData
                                                              ? Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 5,
                                                                      child: TRoundedImage(
                                                                          height:
                                                                              150,
                                                                          width:
                                                                              150,
                                                                          imageUrl:
                                                                              "${snapshots.data![0]['image']}",
                                                                          applyImageRadius:
                                                                              true),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .spaceAround,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .end,
                                                                        children: [
                                                                          ElevatedButton(
                                                                              onPressed:
                                                                                  () async {
                                                                                await Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) => FormEditSpecificationProduct('Edit', listObs[i]['productColor']['product']))
                                                                                );
                                                                                setState(() {
                                                                                  build(context);
                                                                                });
                                                                              },
                                                                              child:
                                                                                  const Icon(Icons.edit)),
                                                                          const Text(
                                                                              '\n'),
                                                                          // ElevatedButton(
                                                                          //     onPressed:
                                                                          //         () async {
                                                                          //       await ProductAPI.deleteProductByID(listObs[i]['id']);
                                                                          //       setState(() {});
                                                                          //     },
                                                                          //     child:
                                                                          //         const Icon(Icons.delete)),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : const Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                )),
                                              Table(
                                                  border: TableBorder.all(),
                                                  children: const [
                                                     TableRow(children: [
                                                      Text('Color'),
                                                      Text('Size'),
                                                      Text('Quantity'),
                                                    ]),
                                                  ]),
                                              ProductSubScreen(listObs[i]['productColor']['product']['id'])
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
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
