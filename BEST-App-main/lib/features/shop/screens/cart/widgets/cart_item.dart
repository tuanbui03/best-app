import 'package:flutter/material.dart';
import '../../../../../api/order_detail_api.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../utils/global_variable/dataApp.dart';

class TCartItems extends StatelessWidget {
  TCartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;
  List listProductCart = [];

  Future<List> _loadDataProductCart() async {
    listProductCart =
        await OrderDetailAPI.getOrderDetailByOrderID(DataApp.orderId);
    return listProductCart;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadDataProductCart(),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ? Column(
                    children: [
                      for (int i = 0; i < snapshot.data!.length; i++)
                        (snapshot.data!.length == 1 ||
                                i == snapshot.data!.length - 1 ||
                                snapshot.data![i]['productDetail']
                                        ['productSize']['product']['id'] !=
                                    snapshot.data![i + 1]['productDetail']
                                        ['productSize']['product']['id'])
                            ? TCartItem(DataApp.orderId,
                                snapshot.data![i]['productDetail']
                                    ['productSize']['product']['id'],
                                0)
                            : const Text('')
                    ],
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
