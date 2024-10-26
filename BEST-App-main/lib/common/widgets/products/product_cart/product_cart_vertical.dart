import 'package:best/api/order_api.dart';
import 'package:best/api/product_color_api.dart';
import 'package:best/common/styles/shadows.dart';
import 'package:best/common/widgets/texts/product_price_text.dart';
import 'package:best/common/widgets/texts/product_title_text.dart';
import 'package:best/common/widgets/texts/t_brand_title_with_verfied_icon.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/product_details/product_detail.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../custom_shapes/containers/rounded_container.dart';
import '../../images/t_rounded_image.dart';
import 'package:get/get.dart';

class TProductCardVertical extends StatefulWidget {
  dynamic product;
  bool isLike;

  TProductCardVertical(this.product, this.isLike, {super.key});
  @override
  State<TProductCardVertical> createState() => _TProductCardVerticalState();
}

class _TProductCardVerticalState extends State<TProductCardVertical> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    dynamic priceSale = widget.product['price'] -
        widget.product['price'] * widget.product['discount'] / 100;
    /// Containers
    return GestureDetector(
      onTap: () {
        DataApp.imageColorID = 0;
        Get.to(() => ProductDetailScreen(widget.product, widget.isLike));},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            // Thumbnail, Wishlist Button, Discount Tag
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  FutureBuilder(
                      future: _loadDataImage(widget.product['id']),
                      builder: (BuildContext ctx,
                              AsyncSnapshot<List> snapshots) =>
                          snapshots.hasData
                              ? TRoundedImage(
                                  imageUrl:
                                      "${snapshots.data![0]['image']}",
                                  applyImageRadius: true)
                              : const Center(
                                  child: CircularProgressIndicator(),
                                )),
                  /// Sale Tag
                  if(widget.product['discount'] != 0)
                    Positioned(
                      top: 12,
                      child: TRoundedContainer(
                        radius: TSizes.sm,
                        backgroundColor: TColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: Text('-${widget.product['discount']}%',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(color: TColors.black)),
                      ),
                    ),
                  /// Favourite Icon Button
                  Positioned(
                      top: 0,
                      right: 0,
                      child:
                          IconButton(
                        onPressed: () {
                          widget.isLike = !widget.isLike;
                          DataApp.checkProductWishlist(DataApp.user['id'], widget.product['id'], widget.isLike);
                          setState(() {});
                        },
                        icon: Icon(
                            widget.isLike
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red),
                      )
                      ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            // Details
            Padding(
              padding: const EdgeInsets.only(left: TSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TProductTitleText(
                        title: '${widget.product['name']}',
                        smallSize: true),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
                    TBrandTitleWithVerifiedIcon(
                        title: '${widget.product['name']}'),
                  ],
                ),
              ),
            ),
            //const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Price
                Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: '$priceSale'),
                ),
                /// Add to Cart
                FutureBuilder(
                    future: loadDataQuantity(widget.product['id']),
                    builder: (BuildContext ctx,
                        AsyncSnapshot<List> snapshots) =>
                    snapshots.hasData
                        ?TProductPriceText(currencySign: '',price:(DataApp.mapQuantitySold[widget.product['id']] == 0)? '': 'Sold : ${DataApp.mapQuantitySold[widget.product['id']]}',)
                    : const Text(''))
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Handle Data
List listImage = [];
Future<List> _loadDataImage(int id) async {
  listImage = await ProductColorAPI.getListProductColorByProductID(id);
  return listImage;
}
// quantityProductSold
Map<int, int> _mapQuantity = {0: 0};
Future<List> loadDataQuantity(int id) async {
  List listQuantityProduct = [1];
  dynamic sum = await OrderAPI.getSumProductSold(id);
  Map<int, int> map = {id: sum};
  _mapQuantity.addEntries(map.entries);
  DataApp.mapQuantitySold = _mapQuantity;
  return listQuantityProduct;
}

