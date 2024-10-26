import 'package:best/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../../api/product_api.dart';
import '../../../../../common/widgets/brand/brand_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';

class TCategoryTab extends StatelessWidget {
  TCategoryTab({super.key});
  List listProduct = [];
  Future<List> _loadDataProduct() async {
    listProduct = await ProductAPI.getProducts();
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Brands
                // TBrandShowCase(images: [
                //   TImages.productImage1,
                //   TImages.productImage1,
                //   TImages.productImage1
                // ]),
                //  TBrandShowCase(images: [
                //   TImages.productImage1,
                //   TImages.productImage1,
                //   TImages.productImage1
                // ]),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Products
                TSectionHeading(title: 'You might like', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems),
                FutureBuilder(
                    future: _loadDataProduct(),
                    builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) =>
                          Card(
                              child: TProductCardVertical(
                                  snapshot.data![index], false)),
                    )
                        : const Center(
                      child: CircularProgressIndicator(),
                    ))
              ],
            ),
          ),
        ]);
  }
}
