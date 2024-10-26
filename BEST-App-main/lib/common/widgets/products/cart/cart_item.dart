import 'package:best/api/order_detail_api.dart';
import 'package:best/api/warehouse_voucher_api.dart';
import 'package:best/common/widgets/products/cart/cart_sub_item.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/product_reviews/widgets/form_feedback.dart';
import 'package:best/features/shop/screens/store/home_shop.dart';
import 'package:best/model/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCartItem extends StatefulWidget {
  int orderID;
  int productID;
  int stateVoucher; //0 text, 1 voucher, 2 vote
  TCartItem(this.orderID,this.productID, this.stateVoucher, {super.key});

  @override
  State<TCartItem> createState() => _TCartItemState();
}

class _TCartItemState extends State<TCartItem> {
  int rating = 0;
  int stateShop = 0;
  // map voucher
  final Map<int, String> _map = {0: ''};
  List listVoucher = [];

  Future<List> _loadDataVoucher(int productID) async {
    listVoucher =
    await WarehouseVoucherAPI.getWarehouseVoucherByUserIDAndProductID(
        DataApp.user['id'], productID);
    if (listVoucher.isNotEmpty) {
      for (var data in listVoucher) {
        Map<int, String> map = {
          data['id']:
          "${data['voucher']['code']}: sale ${data['voucher']['discount_percent']} %"
        };
        _map.addEntries(map.entries);
      }
    }
    return listVoucher;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadDataProductCart(widget.orderID,widget.productID),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
            .hasData
            ? ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) => Column(
              children: [
                (index == 0 &&
                    DataApp.mapShopNameID.containsValue(
                        snapshot.data![0]['productDetail']
                        ['productSize']['product']['id']))
                    ? Column(
                  children: [
                    const Divider(),
                    TextButton(
                        onPressed: () => Get.to(() =>
                            HomeShopScreen(snapshot.data![0]
                            ['productDetail']
                            ['productSize']['product']
                            ['shop'])),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.storefront,
                              size: 30,
                            ),
                            TSectionHeading(
                              title:
                              '  ${snapshot.data![0]['productDetail']['productSize']['product']['shop']['name']}',
                              showActionButton: false,
                            ),
                          ],
                        )),
                    const Divider(),
                  ],
                )
                    : const Text(''),

                TCartSubItem(snapshot.data![index], widget.stateVoucher),

                if(snapshot.data!.length == 1 ||
                    index == snapshot.data!.length - 1)
                    (widget.stateVoucher == 2)
                        ? Row(
                      children: [
                        const TSectionHeading(
                          title: '   Vote',
                          showActionButton: false,
                        ),
                        for (int i = 1; i <= 5; i++)
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                rating = i;
                              });
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) =>
                                          MyRating(
                                              rating,
                                              snapshot
                                                  .data![index]['productDetail']['productSize']['product'])));
                              setState(() {});
                            },
                            icon: Icon(rating > i - 1
                                ? Icons.star
                                : Icons.star_border),
                          ),
                      ],
                    )
                        : (widget.stateVoucher == 1)
                        ? Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Voucher'),
                        FutureBuilder(
                            future: _loadDataVoucher(snapshot
                                .data![index]['productDetail']
                            ['productSize']['product']['id']),
                            builder: (BuildContext ctx,
                                AsyncSnapshot<List>
                                snapshots) =>
                            snapshots.hasData
                                ?
                            DropdownButton<String>(
                              value: (snapshot
                                  .data![index]['warehouseVoucher']['voucher']['id'] !=
                                  1)
                                  ?
                              "${snapshot
                                  .data![index]['warehouseVoucher']['voucher']['code']}: sale ${snapshot
                                  .data![index]['warehouseVoucher']['voucher']['discount_percent']} %"
                                  : '',
                              onChanged: (newValue) {
                                setState(() {
                                  _mapProductVoucher[snapshot
                                      .data![
                                  index][
                                  'productDetail']
                                  [
                                  'productSize']['product']
                                  ['id']] = newValue!;
                                  _map.forEach(
                                          (key, value) async {
                                        if (_mapProductVoucher[
                                        snapshot.data![index]
                                        [
                                        'productDetail']
                                        [
                                        'productSize']
                                        [
                                        'product']['id']] ==
                                            value) {
                                          _mapProductVoucherID[snapshot
                                              .data![index]
                                          [
                                          'productDetail']
                                          [
                                          'productSize']
                                          [
                                          'product']['id']] = key;
                                          await reloadData();
                                          setState(() {});
                                          DataApp.voucherID =
                                              key;
                                          DataApp.voucher_discount =
                                              value;
                                        }
                                      });
                                });
                              },
                              items: [
                                for (MapEntry<int,
                                    String> e
                                in _map.entries)
                                  DropdownMenuItem(
                                    value: e.value,
                                    child: Text(e.value),
                                  ),
                              ],
                            )
                                : const Text('')),
                      ],
                    )
                        : const Text('')
              ],
            ))
            : const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

//Handle Data
List listProductCart = [];
Map<int, int> _mapProductVoucherID = {};

Future reloadData() async {
  for (var data in listProductCart) {
    if (_mapProductVoucherID[data['productDetail']['productSize']['product']
    ['id']] !=
        null) {
      OrderDetail orderDetail = OrderDetail(
          data['id'],
          data['order']['id'],
          _mapProductVoucherID[data['productDetail']['productSize']['product']
          ['id']]!,
          data['productDetail']['id'],
          data['quantity'],
          data['price']);
      await OrderDetailAPI.updateOrderDetail(orderDetail);
    }
  }
}

dynamic getPriceSale(dynamic data) {
  return data['productDetail']['productSize']['product']['price'] -
      data['productDetail']['productSize']['product']['price'] *
          data['productDetail']['productSize']['product']['discount'] /
          100;
}

dynamic getTotalPrice(dynamic data) {
  return (data['quantity'] * getPriceSale(data)) *
      (100 - data['warehouseVoucher']['voucher']['discount_percent']) /
      100;
}

Map<int, String> _mapProductVoucher = {};

Future<List> _loadDataProductCart(int orderID,int productID) async {
  listProductCart = await OrderDetailAPI.getOrderDetailByOrderIDAndProductID(
      orderID, productID);
  for (var data in listProductCart) {
    _mapProductVoucher[data['productDetail']['productSize']['product']['id']] =
    "${data['warehouseVoucher']['voucher']['code']}: sale ${data['warehouseVoucher']['voucher']['discount_percent']} %";
  }
  return listProductCart;
}
