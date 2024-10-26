import 'package:best/api/product_color_api.dart';
import 'package:best/api/product_detail_api.dart';
import 'package:best/api/product_size_api.dart';
import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductSubScreen extends StatelessWidget {
  int productID;
  ProductSubScreen(this.productID, {super.key});
  List listColor = [];
  List listSize = [];
  List listDataProductDetail = [];
  Future<List> _loadDataProductColor(int productID) async {
    listColor = await ProductColorAPI.getListProductColorByProductID(productID);
    listSize = await ProductSizeAPI.getProductSizeByProductID(productID);
    listDataProductDetail = await ProductDetailAPI.getProductDetailByShopIDAndProductID(DataApp.userShopID['id'], productID);
    return listColor;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadDataProductColor(productID),
        builder: (BuildContext ctx,
            AsyncSnapshot<List>
            snapshots) =>
        snapshots.hasData
            ?
        Table(
            children: [
              for(int c = 0; c < snapshots.data!.length; c++)//load color
                TableRow(children: [
                  Table(border: TableBorder.all(), children: [
                    TableRow(children: [
                      Column(
                        children: [
                          Text(' ${snapshots.data![c]['color']['name']}',),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: TRoundedImage(
                                imageUrl:
                                snapshots.data![c]['image'],
                                applyImageRadius: true),
                          ),
                        ],
                      ),
                      Table(border: TableBorder.all(), children:  [
                        for(int s = 0; s < listSize.length; s++)//load size
                          TableRow(children: [
                            Text('${listSize[s]['size']['size']}'),
                          ]),
                      ]),
                      Table(border: TableBorder.all(), children:  [
                        for(int s = 0; s < listSize.length; s++)//load size
                          for(int data = 0; data < listDataProductDetail.length; data++)
                          if(snapshots.data![c]['color']['id'] == listDataProductDetail[data]['productColor']['color']['id'] &&
                              listSize[s]['size']['id'] == listDataProductDetail[data]['productSize']['size']['id'])
                          TableRow(children: [
                            Text('${listDataProductDetail[data]['quantity']}')
                          ]),
                      ]),
                    ]),
                  ]),
                ]),
            ]):Text(''));

  }
}
