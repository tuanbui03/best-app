import 'package:best/api/product_api.dart';
import 'package:best/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:best/features/shop/screens/all_products/all_products.dart';
import 'package:best/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:best/features/shop/screens/home/widgets/home_categories.dart';
import 'package:best/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List listProduct = [];
  Future<List> _loadDataProduct() async {
    listProduct = await ProductAPI.getProductPopular();
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            const TPrimaryHeaderContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Appbar
                  THomeAppBar(),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Searchbar
                  TSearchContainer(text: "Search "),
                  SizedBox(height: TSizes.spaceBtwSections),

                  /// Categories
                    Padding(
                    padding: EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Heading
                        TSectionHeading(
                          title: 'Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwItems),
                        /// Categories
                        THomeCategories()
                      ],
                    ),
                  ),

                  SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Slide
                  const TPromoSlider(banners: [
                    TImages.promoBanner1,
                    TImages.promoBanner2,
                    TImages.promoBanner3
                  ]),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  /// Heading
                  TSectionHeading(
                      title: 'Popular Products',
                      onPressed: () => Get.to(() => const AllProduct())),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  FutureBuilder(
                      future: _loadDataProduct(),
                      builder:
                          (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                              snapshot.hasData
                                  ? TGridLayout(
                                      itemCount: listProduct.length,
                                      itemBuilder: (_, index) =>
                                          TProductCardVertical(
                                              snapshot.data![index], false),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
