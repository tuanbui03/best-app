import 'package:best/api/shop_api.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../api/product_api.dart';
import '../../../../features/shop/screens/product_reviews/product_findby.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  const TSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    List listProductSearch = [];
    List listShopSearch = [];
    final dark = THelperFunctions.isDarkMode(context);
    final searchCtr = TextEditingController();
    searchCtr.text = DataApp.textFind;
    return Padding(
      padding: padding,
      child: Container(
        width: 450,
        decoration: BoxDecoration(
          color: showBackground
              ? dark
                  ? TColors.dark
                  : TColors.light
              : Colors.transparent,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: TColors.grey) : null,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: TextField(
                controller: searchCtr,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DataApp.textFind = searchCtr.text;
                        String textFirst = "productName : ${searchCtr.text}";
                        listProductSearch =
                        await ProductAPI.getProductBySearch(searchCtr.text);
                        listShopSearch = await ShopAPI.getShopBySearchName(searchCtr.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => ProductFindAttribute(
                                    textFirst, listProductSearch, listShopSearch)));
                      },
                      icon: Icon(icon, color: TColors.darkerGrey),
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
