import 'package:best/api/product_color_api.dart';
import 'package:best/api/wishlist_api.dart';
import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/common/widgets/icons/t_circular_icon.dart';
import 'package:best/features/shop/screens/home/home.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import '../../../../common/styles/shadows.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../../common/widgets/texts/t_brand_title_with_verfied_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../product_details/product_detail.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    bool isLike = true;
    return Scaffold(
      appBar: TAppBar(
        title:
        Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              FutureBuilder(
                  future: _loadDataWishlistByUser(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) =>
                          Card(
                              child: GestureDetector(

                                onTap: () {
                                  DataApp.imageColorID = 0;
                                  Get.to(() =>
                                    ProductDetailScreen(
                                        snapshot.data![index]['product'],
                                        false));},
                                child: Container(
                                  width: 180,
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      TShadowStyle.verticalProductShadow
                                    ],
                                    borderRadius: BorderRadius.circular(
                                        TSizes.productImageRadius),
                                    color: dark
                                        ? TColors.darkerGrey
                                        : TColors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      // Thumbnail, Wishlist Button, Discount Tag
                                      TRoundedContainer(
                                        height: 180,
                                        padding:
                                        const EdgeInsets.all(TSizes.sm),
                                        backgroundColor: dark
                                            ? TColors.dark
                                            : TColors.light,
                                        child: Stack(
                                          children: [
                                            /// Thumbnail Image
                                            FutureBuilder(
                                                future: _loadDataImage(
                                                    snapshot.data![index]
                                                    ['product']
                                                    ['id']),
                                                builder: (BuildContext ctx,
                                                    AsyncSnapshot<List>
                                                    snapshots) =>
                                                snapshots.hasData
                                                    ? TRoundedImage(
                                                    imageUrl:
                                                    "${snapshots.data![0]['image']}",
                                                    applyImageRadius:
                                                    true)
                                                    : const Center(
                                                  child:
                                                  CircularProgressIndicator(),
                                                )),

                                            /// Sale Tag
                                            Positioned(
                                              top: 12,
                                              child: TRoundedContainer(
                                                radius: TSizes.sm,
                                                backgroundColor: TColors
                                                    .secondary
                                                    .withOpacity(0.8),
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: TSizes.sm,
                                                    vertical: TSizes.xs),
                                                child: Text(
                                                    '-${snapshot.data![index]['product']['discount']}%',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelLarge!
                                                        .apply(
                                                        color: TColors
                                                            .black)),
                                              ),
                                            ),

                                            /// Favourite Icon Button
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: IconButton(
                                                  onPressed: () async {
                                                    isLike = !isLike;
                                                    if (!isLike) {
                                                      dynamic ob = await WishlistAPI
                                                          .getWishlistByUserIDAndProductID(
                                                          DataApp.user[
                                                          'id'],
                                                          snapshot.data![
                                                          index]
                                                          [
                                                          'product']
                                                          [
                                                          'id']);
                                                      await WishlistAPI
                                                          .deleteWishlistByID(ob['id']);
                                                    }
                                                    setState(() {});
                                                  },
                                                  icon: Icon(
                                                      isLike
                                                          ? Icons.favorite
                                                          : Icons
                                                          .favorite_border,
                                                      color: Colors.red),
                                                )),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                          height: TSizes.spaceBtwItems / 2),
                                      // Details
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: TSizes.sm),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              TProductTitleText(
                                                  title:
                                                  '${snapshot.data![index]['product']['name']}',
                                                  smallSize: true),
                                              const SizedBox(
                                                  height:
                                                  TSizes.spaceBtwItems /
                                                      2),
                                              TBrandTitleWithVerifiedIcon(
                                                  title:
                                                  '${snapshot.data![index]['product']['name']}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      //const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          /// Price
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: TSizes.sm),
                                            child: TProductPriceText(
                                                price:
                                                '${snapshot.data![index]['product']['price'] - snapshot.data![index]['product']['price'] * snapshot.data![index]['product']['discount'] / 100}'),
                                          ),

                                          /// Add to Cart
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: TColors.dark,
                                              borderRadius:
                                              BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    TSizes.cardRadiusMd),
                                                bottomRight:
                                                Radius.circular(TSizes
                                                    .productImageRadius),
                                              ),
                                            ),
                                            child: const SizedBox(
                                              width: TSizes.iconLg * 1.2,
                                              height: TSizes.iconLg * 1.2,
                                              child: Center(
                                                  child: Icon(Iconsax.add,
                                                      color:
                                                      TColors.white)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )))
                      : const Center(
                    child: CircularProgressIndicator(),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
//Handle Data

//
List listImage = [];
Future<List> _loadDataImage(int id) async {
  listImage = await ProductColorAPI.getListProductColorByProductID(id);
  return listImage;
}

List listWishlistByUser = [];
Future<List> _loadDataWishlistByUser() async {
  listWishlistByUser =
  await WishlistAPI.getWishlistByUserID(DataApp.user['id']);
  return listWishlistByUser;
}
