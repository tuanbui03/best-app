import 'package:best/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../api/order_api.dart';
import '../../../../../api/order_detail_api.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../utils/global_variable/dataApp.dart';
List listProductCart = [];
Future<List> _loadDataProductCart(int orderID) async {
  DataApp.mapShopNameID.clear();
  listProductCart =
  await OrderDetailAPI.getOrderDetailByOrderID(orderID);
  double totalPayment = 0;
  for (var data in listProductCart) {
    Map<int, int> mapShop = {data['productDetail']['productSize']['product']['shop']['id'] : data['productDetail']['productSize']['product']['id']};
    if(!DataApp.mapShopNameID.containsKey(data['productDetail']['productSize']['product']['shop']['id'])) {
      DataApp.mapShopNameID.addEntries(mapShop.entries);
    }
    double priceSale = data['quantity'] *
        data['productDetail']['productSize']['product']['price'] *
        (100 - data['productDetail']['productSize']['product']['discount']) /
        100;
    double priceVoucher = priceSale * (100 - data['warehouseVoucher']['voucher']['discount_percent'])/100;
    totalPayment += priceVoucher;
  }
  DataApp.total = totalPayment ;
  return listProductCart;
}

class TOrderListItems extends StatefulWidget {
  const TOrderListItems({super.key});

  @override
  State<TOrderListItems> createState() => _TOrderListItemsState();
}

class _TOrderListItemsState extends State<TOrderListItems> {
  int rating = 0;
  List listOrderHistory = [];
  Future<List> _loadDataOrderHistory() async {
    listOrderHistory = await OrderAPI.getOrderDisAction(DataApp.user['id']);
    return listOrderHistory;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: _loadDataOrderHistory(),
        builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
            .hasData
            ? ListView.separated(
          shrinkWrap: true,
          itemCount: listOrderHistory.length,
          separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwItems),
          itemBuilder: (_, index) => TRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(TSizes.md),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Column(
              children: [
                /// Row 1
                Row(
                  children: [
                    /// Icon
                    const Icon(Iconsax.ship),
                    const SizedBox(width: TSizes.spaceBtwItems / 2),

                    /// Status & Date
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Processing  ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(
                                color: TColors.primary,
                                fontWeightDelta: 1),
                          ),
                          Text(
                              '${listOrderHistory[index]['created_at'].substring(0, 10)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall),
                        ],
                      ),
                    ),

                    /// Icon
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.arrow_right_34,
                            size: TSizes.iconSm)),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Row 2
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          /// Icon
                          // const Icon(Iconsax.tag),
                          // const SizedBox(width: TSizes.spaceBtwItems / 2),

                          /// Status & Date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // Text('Order',
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .labelMedium),
                                Text(
                                    '   Order [#${listOrderHistory[index]['id']}]',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                FutureBuilder(
                                    future: _loadDataProductCart(listOrderHistory[index]['id']),
                                    builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                                    snapshot.hasData
                                        ? Column(children: [
                                              for( int i = 0; i < snapshot.data!.length; i++)
                                                (snapshot.data!.length == 1 || i == snapshot.data!.length-1 || snapshot.data![i]['productDetail']['productSize']['product']['id'] != snapshot.data![i+1]['productDetail']['productSize']['product']['id'])?
                                                TCartItem(snapshot.data![i]['order']['id'],snapshot.data![i]['productDetail']['productSize']['product']['id'], 2)
                                                    :const Text('')
                                            ],
                                    ):
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Money',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge),
                    Text('${listOrderHistory[index]['total']}\$',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium),
                  ],
                )
              ],
            ),
          ),
        )
            : const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
