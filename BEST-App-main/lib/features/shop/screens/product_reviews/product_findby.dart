import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/store/home_shop.dart';
import 'package:best/features/shop/screens/store/page/widgets/shop_title.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/products/product_cart/product_cart_vertical.dart';

class ProductFindAttribute extends StatelessWidget {
  dynamic listDataProduct;
  dynamic listDataShop;
  String textSearch;
  ProductFindAttribute(this.textSearch,this.listDataProduct, this.listDataShop, {super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TAppBar(
          title:
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text('     Search Results', style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          actions: [
            TCartCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : TColors.white,
                  expandedHeight: 150,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        /// Search bar
                        SizedBox(height: TSizes.spaceBtwItems),
                        TSearchContainer(
                            text: '',
                            showBorder: true,
                            showBackground: false,
                            padding: EdgeInsets.zero),
                        SizedBox(height: TSizes.spaceBtwSections),
                      ],
                    ),
                  ),)
            ];
          },
          body: /// Brands Grid
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SHOP related to "${DataApp.textFind}"'),
                  const Divider(),
                  for(final data in listDataShop)
                    TextButton(
                      onPressed: () =>
                        Get.to(() => HomeShopScreen(data)),
                      child:
                      ShopTitle(data)
                    ),
                  Text('\nProduct related to "${DataApp.textFind}"'),
                  const Divider(),
                  TGridLayout(
                    itemCount: listDataProduct.length,
                    itemBuilder: (_, index) =>
                        TProductCardVertical(
                            listDataProduct[index], false),
                  ),
                ],
              ),
            ),
          )

        ),
      ),
    );
  }
}
