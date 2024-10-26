import 'package:best/api/order_detail_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/cart/cart.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constants/colors.dart';

List listProductCart = [];
Future<List> _loadProductCart() async {
  listProductCart = await OrderDetailAPI.getOrderDetailByOrderID(DataApp.orderId);
  return listProductCart;
}

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    _loadProductCart();
    final dark = THelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: () => Get.offAll(() => CartScreen()),
            icon: Icon(Iconsax.shopping_bag, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
                color: counterBgColor ?? (dark ? TColors.white : TColors.black),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
                child: FutureBuilder(
                    future: _loadProductCart(),
                    builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                        snapshot.hasData
                            ? Text('${listProductCart.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .apply(
                                        color: TColors.white,
                                        fontSizeFactor: 0.8))
                            : const Center(
                                child: CircularProgressIndicator(),
                              ))),
          ),
        )
      ],
    );
  }
}
