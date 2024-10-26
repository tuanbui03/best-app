import 'package:best/api/product_color_api.dart';
import 'package:best/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/constants/image_strings.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../../api/product_api.dart';
import '../../../../../common/widgets/brand/brand_show_case.dart';

class TCategoryTab extends StatelessWidget {
  dynamic brand;
  TCategoryTab(this.brand,{super.key});
  List listProduct = [];
  List listImage = [];
  Future<List> _loadDataProduct() async {
    listProduct = await ProductAPI.getProductByBrandID(brand['id']);
    if(listProduct.isNotEmpty) {
      listImage = await ProductColorAPI.getListProductColorByProductID(listProduct[0]['id']);
    }
    return listProduct;
  }
  @override
  Widget build(BuildContext context) {
    return
      FutureBuilder(
          future: _loadDataProduct(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
          snapshot.hasData
              ?ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Brands
                if(listImage.isNotEmpty)
                  TBrandShowCase(brand,images: [
                     for(int i = 0; i < listImage.length;i ++)
                       if(i < 3)
                        '${listImage[i]['image']}',
                ]),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Products
                TSectionHeading(title: 'You might like', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems),
                 if(listProduct.isNotEmpty)
                    Card(
                        child: TProductCardVertical(
                            listProduct[0], false)),
              ],
            ),
          ),
        ])  : const Center(
            child: CircularProgressIndicator(),
          ));
  }
}
