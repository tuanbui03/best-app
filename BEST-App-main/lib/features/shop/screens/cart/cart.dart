import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/features/shop/screens/checkout/checkout.dart';
import 'package:best/navigation_menu.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../api/order_detail_api.dart';
import '../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../utils/global_variable/dataApp.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool checkReload = true;
  Map<int, String> mapCore = {};
  Map<int, String> mapWarehouse = {};
  @override
  Widget build(BuildContext context) {
    DataApp.sizeID = 0;
    DataApp.colorID = 0;
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
            children: [
              // (DataApp.stateShop)?
            IconButton(
            onPressed: () {
              DataApp.stateShop = !DataApp.stateShop;
              Get.offAll(() => const NavigationMenu());
            },
          icon: const Icon(Icons.arrow_back)),
                // :const Text(''),
        Text('Cart', style: Theme.of(context).textTheme.headlineSmall)
      ]),
    ),
      body: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          /// Items in Cart
          child:
          SingleChildScrollView(
            child:
            FutureBuilder(
                future: _loadDataProductCart(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ?Column(children: [
                          for( int i = 0; i < snapshot.data!.length; i++)
                            (snapshot.data!.length == 1 || i == snapshot.data!.length-1 || snapshot.data![i]['productDetail']['productSize']['product']['id'] != snapshot.data![i+1]['productDetail']['productSize']['product']['id'])?
                            TCartItem(snapshot.data![i]['order']['id'],snapshot.data![i]['productDetail']['productSize']['product']['id'], 1)
                                :const Text('')
                        ],
                ):
                const Center(
                  child: CircularProgressIndicator(),
                )
            ),
          )
      ),
      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () async{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => CheckoutScreen()));
              //DataApp.total = 0;
            },
            child: const Text('Purchase')),
      ),
    );
  }
}

List listProductCart = [];
Map<int, String> _mapProductVoucher = {};
Future<List> _loadDataProductCart() async {
  DataApp.mapShopNameID.clear();
  listProductCart = await OrderDetailAPI.getOrderDetailByOrderID(DataApp.orderId);
  double totalPayment = 0;
  for (var data in listProductCart) {
    Map<int, int> mapShop = {data['productDetail']['productSize']['product']['shop']['id'] : data['productDetail']['productSize']['product']['id']};
    if(!DataApp.mapShopNameID.containsKey(data['productDetail']['productSize']['product']['shop']['id'])) {
      DataApp.mapShopNameID.addEntries(mapShop.entries);
    }
    double priceSale = data['quantity'] *
        data['productDetail']['productSize']['product']['price'] *
        (100 - data['productDetail']['productSize']['product']['discount']) /100;
    double priceVoucher = priceSale * (100 - data['warehouseVoucher']['voucher']['discount_percent'])/100;
    totalPayment += priceVoucher;
    _mapProductVoucher[data['productDetail']['productSize']['product']['id']] = "${data['warehouseVoucher']['voucher']['code']}: sale ${data['warehouseVoucher']['voucher']['discount_percent']} %";
  }
  DataApp.total = totalPayment ;
  return listProductCart;
}
