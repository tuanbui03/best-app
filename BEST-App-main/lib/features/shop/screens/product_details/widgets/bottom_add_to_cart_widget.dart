import 'package:best/common/widgets/icons/t_circular_icon.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/cart/cart.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TBottomAddToCart extends StatefulWidget {
  dynamic product;

  TBottomAddToCart(this.product, {super.key});

  @override
  _TBottomAddToCart createState() => _TBottomAddToCart();
} // Class SecondRoute

class _TBottomAddToCart extends State<TBottomAddToCart> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final quantityCtrl = TextEditingController();
    quantityCtrl.text = quantity.toString();
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
          color: dark ? TColors.darkerGrey : TColors.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(TSizes.cardRadiusLg),
            topRight: Radius.circular(TSizes.cardRadiusLg),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (quantity > 1) {
                      quantity--;
                    }
                  });
                },
                icon: TCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: TColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              SizedBox(
                width: 60,
                height: 50,
                child: TextField(
                    controller: quantityCtrl,
                    onChanged: (value) {
                      if (value == '0' || value.isEmpty) {
                        quantityCtrl.text = value = 1.toString();
                      }
                      if (int.parse(value) > DataApp.sumProduct){
                        quantityCtrl.text = value = '${DataApp.sumProduct}';
                      }
                      quantity = int.parse(value);
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border:  OutlineInputBorder(),
                    )),
              ),
              //  Text('$quantity', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              IconButton(
                onPressed: () {
                  setState(() {
                    if(quantity < DataApp.sumProduct) {
                      quantity++;
                    }
                  });
                },
                icon:  TCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: TColors.black,
                  width: 40,
                  height: 40,
                  color: TColors.white,
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if(DataApp.colorID == 0 || DataApp.sizeID == 0){
                showDialog(
                    context: context,
                    builder: (builder) {
                      return const AlertDialog(
                        content: Text('Please select color and size for the product!'),
                      );
                    });
              } else if (quantity > (DataApp.sumProduct - DataApp.sumProductCart) ) {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return AlertDialog(
                          content: Text('You can purchase up to ${DataApp.sumProduct - DataApp.sumProductCart} products.\n Because your cart has ${DataApp.sumProductCart} products'),
                        );
                      });
                }else {
                    List discountPercent = "abc: sale 0 %".split(' ');
                    DataApp.voucherID = 1;
                    await DataApp.handleCart(
                        widget.product, quantity, discountPercent);
                    Get.offAll(() => CartScreen());
                  }
              },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.black,
              side: const BorderSide(color: TColors.black),
            ),
            child: const Text('Add to Cart'),
          )
        ],
      ),
    );
  }
}