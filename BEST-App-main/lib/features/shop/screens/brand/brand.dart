import 'package:best/api/brand_api.dart';
import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/common/widgets/appbar/tabbar.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/brand/all_brands.dart';
import 'package:best/features/shop/screens/brand/brand_products.dart';
import 'package:best/features/shop/screens/brand/widgets/category_tab.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/brand/brand_card.dart';

class BrandScreen extends StatelessWidget {
  BrandScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TAppBar(
          title:
          Text('Brand', style: Theme.of(context).textTheme.headlineMedium),
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
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        /// Search bar
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Featured Brands
                        TSectionHeading(
                            title: 'Featured Brands', onPressed:  () => Get.to(() =>  AllBrandScreen(DataApp.listBrand))),
                        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                        /// Brands Grid
                        TGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) => TBrandCard(brand: DataApp.listBrand[index],
                                onTap: () => Get.to(() =>  BrandProducts(DataApp.listBrand[index])),
                                showBorder: false))

                      ],
                    ),
                  ),
                  /// Tabs
                  bottom: TTabBar(tabs: [
                    for(int i = 0; i < 4; i++)
                      Tab(child: Text(DataApp.listBrand[i]['name']),),
                  ],)
              )
            ];
          },
          body:
          TabBarView(
            children: [
              for(int i = 0; i < 4; i++)
                TCategoryTab(DataApp.listBrand[i]),
            ],
          ),
        ),
      ),
   );
  }
}
