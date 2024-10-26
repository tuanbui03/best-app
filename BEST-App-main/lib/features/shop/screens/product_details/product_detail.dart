import 'package:best/api/order_detail_api.dart';
import 'package:best/api/product_api.dart';
import 'package:best/api/product_color_api.dart';
import 'package:best/api/product_detail_api.dart';
import 'package:best/api/product_size_api.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:best/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:best/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:best/features/shop/screens/product_reviews/product_description.dart';
import 'package:best/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:best/features/shop/screens/product_reviews/review_screen.dart';
import 'package:best/features/shop/screens/store/home_shop.dart';
import 'package:best/features/shop/screens/store/page/widgets/shop_title.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/chip/choice_chip.dart';
import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../common/widgets/texts/product_price_text.dart';
import '../../../../common/widgets/texts/product_title_text.dart';
import '../../../../utils/global_variable/dataApp.dart';
import '../../../../utils/constants/colors.dart';

class ProductDetailScreen extends StatefulWidget {
  bool isLike;
  dynamic product;

  ProductDetailScreen(this.product, this.isLike, {super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int isColor = 0;
  bool stateColor = false;
  int isSize = 0;
  int colorID = 0;
  int sizeID = 0;
  int rating = 0;
  bool stateFormFB = true;
  //load DataProductColor - color
  List listProductColor = [];
  Map<int, int> mapColor = {0: 0};
  Future<List> _loadDataProductColor(int productID) async {
    //listColorBySize
    if(sizeID != 0) {
      mapColorBySize.clear();
      for (var data in listProductColor) {
        int countPColor = await ProductDetailAPI
            .getSumProductDetailByColorIAndSizeID(data['id'], sizeID);
        Map<int, int> map = {data['id']: countPColor};
        mapColorBySize.addEntries(
            map.entries); // map size [product_size_id, quantity]
      }
    }
    listProductColor =
    await ProductColorAPI.getListProductColorByProductID(productID);// list color by product
    for (var data in listProductColor) {
      int countPColor =
      await ProductDetailAPI.getSumProductDetailByColorID(data['id']);
      Map<int, int> map = {data['id']: countPColor};
      mapColor.addEntries(map.entries);// map color [ product_color_id, quantity]
    }
    return listProductColor;
  }
  //load DataProductSize - size
  List listProductSize = [];
  Map<int, int> mapSize = {0: 0};
  Future<List> _loadDataProductSize(int productID) async {
    listProductSize = await ProductSizeAPI.getProductSizeByProductID(productID);// list size by product
    for (var data in listProductSize) {
      int countPSize =
      await ProductDetailAPI.getSumProductDetailBySizeID(data['id']);
      Map<int, int> map = {data['id']: countPSize};
      mapSize.addEntries(map.entries);// map size [product_size_id, quantity]
    }
    return listProductSize;
  }
  //load DataColorBySize - size
  List listColorBySize = [];
  Map<int, int> mapColorBySize = {0: 0};
  //load quantity by color_size
  int quantity = 0;
  Map<int, int> mapColorSize = {0: 0};
  Future<List> _loadDataProductQuantity(int colorID, int sizeID, int quantityProduct) async {
    //
    mapColorSize.clear();
    for (var data in listProductSize) {
      int countPCSize =
      await ProductDetailAPI.getSumProductDetailByColorIAndSizeID(
          colorID, data['id']);
      Map<int, int> map = {data['id']: countPCSize};
      mapColorSize.addEntries(map.entries);
    }
    (colorID == 0 && sizeID == 0)
        ? quantity = quantityProduct
        : (colorID != 0 && sizeID == 0)
        ? quantity = mapColor[colorID]!
        : (colorID == 0 && sizeID != 0)
        ? quantity = mapSize[sizeID]!
        : quantity = mapColorSize[sizeID]!;
    dynamic productDetailID =
    await ProductDetailAPI.getProductDetailByProductIdAndColorIdAndSizeID(
        widget.product['id'], colorID, sizeID);
    try {
      dynamic result =
      await OrderDetailAPI.getOrderDetailByOrderIDAndProductDetailID(
          DataApp.orderId, productDetailID['id']);
      DataApp.sumProductCart = result['quantity'];
    } on Exception catch (_) {
      DataApp.sumProductCart = 0;
    }
    DataApp.sumProduct = quantity;
    return listProductSize;
  }
  //listProductRemain
  List listProduct = [];
  Future<List> _loadDataProduct() async {
    listProduct = await ProductAPI.getProductRemain(widget.product['shop']['id'], widget.product['id']);
    return listProduct;
  }
  //
  @override
  Widget build(BuildContext context) {
    DataApp.product = widget.product;
    if (stateColor) {
      isColor = DataApp.imageColorID;
    }
    dynamic priceSale =
        widget.product['price'] * (100 - widget.product['discount']) / 100;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(widget.product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Image Slider
            TCurvedEdgeWidget(
              child: Container(
                color: dark ? TColors.darkerGrey : TColors.light,
                child: Stack(
                  children: [
                    /// Main Image
                    SizedBox(
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                        child: Center(
                          child: FutureBuilder(
                              future: _loadDataImage(widget.product['id']),
                              builder: (BuildContext ctx,
                                  AsyncSnapshot<List> snapshots) =>
                              snapshots.hasData
                                  ? Image(
                                  image: AssetImage(checkImage(
                                      listImage, DataApp.imageColorID)))
                                  : const Center(
                                child: CircularProgressIndicator(),
                              )),
                        ),
                      ),
                    ),

                    /// Image Slider
                    Positioned(
                      right: 0,
                      bottom: 28,
                      left: TSizes.defaultSpace,
                      child: SizedBox(
                        height: 80,
                        child: FutureBuilder(
                            future: _loadDataImage(widget.product['id']),
                            builder: (BuildContext ctx,
                                AsyncSnapshot<List> snapshots) =>
                            snapshots.hasData
                                ? ListView.separated(
                                separatorBuilder: (_, __) =>
                                const SizedBox(
                                  width: TSizes.spaceBtwItems,
                                ),
                                itemCount: snapshots.data!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) => TextButton(
                                  onPressed: () {
                                    DataApp.imageColorID =
                                    snapshots.data![index]
                                    ['color']['id'];
                                    setState(() {
                                      // stateColor = true;
                                      checkImage(listImage,
                                          DataApp.imageColorID);
                                    });
                                  },
                                  child: TRoundedImage(
                                    width: 60,
                                    backgroundColor: dark
                                        ? TColors.dark
                                        : TColors.white,
                                    border: Border.all(
                                        color: TColors.primary),
                                    padding: const EdgeInsets.all(
                                        TSizes.sm),
                                    imageUrl:
                                    "${snapshots.data![index]['image']}",
                                  ),
                                ))
                                : const Center(
                              child: CircularProgressIndicator(),
                            )),
                      ),
                    ),

                    /// Appbar Icons
                    TAppBar(
                      showBackArrow: true,
                      actions: [
                        IconButton(
                          onPressed: () {
                            widget.isLike = !widget.isLike;
                            DataApp.checkProductWishlist(DataApp.user['id'],
                                widget.product['id'], widget.isLike);
                            setState(() {});
                          },
                          icon: Icon(
                              widget.isLike
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            /// Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  TProductTitleText(title: '${widget.product['name']}'),

                  /// Rating & share button
                  TRatingAndShare(widget.product),
                  const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                  TProductTitleText(
                      title: 'Brand: ${widget.product['brand']['name']}'),
                  const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                  /// Price, title, stock & brand
                  TProductMetaData(widget.product),

                  /// Attributes
                  Column(children: [
                    /// Selected Attribute Pricing & Description
                    TRoundedContainer(
                      padding: const EdgeInsets.all(TSizes.md),
                      backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
                      child: Column(
                        children: [
                          /// Title, Price and Stock Status
                          Row(
                            children: [
                              const TSectionHeading(
                                  title: 'Variation', showActionButton: false),
                              const SizedBox(width: TSizes.spaceBtwItems),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const TProductTitleText(
                                          title: 'Price', smallSize: true),
                                      const SizedBox(
                                          width: TSizes.spaceBtwItems),

                                      /// Actual Price
                                      Text(
                                        '\$${widget.product['price']}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .apply(
                                            decoration:
                                            TextDecoration.lineThrough),
                                      ),
                                      const SizedBox(
                                          width: TSizes.spaceBtwItems),

                                      /// Sale Price
                                      TProductPriceText(price: '$priceSale'),
                                    ],
                                  ),

                                  /// Stock
                                  Row(
                                    children: [
                                      const TProductTitleText(
                                          title: 'Stock    ', smallSize: true),
                                      Text(
                                          (widget.product['status'] == 1)
                                              ? 'Open'
                                              : 'Close',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          /// Description
                          TProductTitleText(
                            title: 'Code : ${widget.product['code']}',
                            smallSize: true,
                            //maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems),
//                                                                                                                //Quantity    324
                    /// Attributes
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const TSectionHeading(
                                title: 'Quantity  ',
                                showActionButton: false,
                              ),
                              FutureBuilder(
                                future: _loadDataProductQuantity(colorID,
                                    sizeID, widget.product['quantity']),
                                builder: (BuildContext ctx,
                                    AsyncSnapshot<List> snapshot) =>
                                    Text('$quantity'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
//                                                                                                                //Color    349
                    //
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3,
                          child: Row(
                            children: [
                              const TSectionHeading(
                                title: 'Color   ',
                                showActionButton: false,
                              ),
                              FutureBuilder(
                                  future: _loadDataProductColor(widget.product['id']),
                                  builder: (BuildContext ctx,
                                      AsyncSnapshot<List> snapshot) =>
                                  snapshot.hasData
                                      ? Wrap(
                                    // spacing: 8,
                                    children: [
                                      for (int i = 0;i < listProductColor.length;i++)
                                        TChoiceChip(
                                          text:'${listProductColor[i]['color']['name']}',
                                          onSelected: (sizeID == 0)?(mapColor[listProductColor[i]['id']] ==0)? null
                                              : (value) {
                                            setState(() {
                                              stateColor =false;
                                              isColor =listProductColor[i]['color']['id'];
                                              colorID =listProductColor[i]['id'];
                                              DataApp.imageColorID =isColor;
                                              DataApp.colorID =colorID;
                                            });
                                          }
                                              : (mapColorBySize[listProductColor[i]['id']] ==0)? null
                                              : (value) {
                                            setState(() {
                                              isColor =listProductColor[i]['color']['id'];
                                              colorID =listProductColor[i]['id'];
                                              DataApp.imageColorID =isColor;
                                              DataApp.colorID =colorID;
                                            });
                                          },
                                          selected: isColor == listProductColor[i]['color']['id'],
                                        ),
                                    ],
                                  )
                                      : const Center(
                                    child:
                                    CircularProgressIndicator(),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwItems / 2),
//                                                                                                                //Size    418
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const TSectionHeading(
                                title: 'Size   ',
                                showActionButton: false,
                              ),
                              const SizedBox(height: TSizes.spaceBtwItems / 2),
                              FutureBuilder(
                                  future: _loadDataProductSize(widget.product['id']),
                                  builder: (BuildContext ctx,
                                      AsyncSnapshot<List> snapshot) =>
                                  snapshot.hasData
                                      ? Wrap(
                                    spacing: 8,
                                    children: [
                                      for (int i = 0;i < listProductSize.length;i++)
                                        TChoiceChip(text:'${listProductSize[i]['size']['size']}',
                                          onSelected: (colorID == 0) ? (mapSize[listProductSize[i]['id']] ==0)? null
                                              : (value) {
                                            setState(() {
                                              isSize = listProductSize[i]['size']['id'];
                                              sizeID =listProductSize[i]['id'];
                                              DataApp.sizeID =sizeID;
                                            });
                                          }
                                              : (mapColorSize[listProductSize[i]['id']] ==0)? null
                                              : (value) {
                                            setState(() {
                                              isSize = listProductSize[i]['size']['id'];
                                              sizeID =listProductSize[i]['id'];
                                              DataApp.sizeID =sizeID;
                                            });
                                          },
                                          selected: isSize ==listProductSize[i]['size']['id'],
                                        ),
                                    ],
                                  )
                                      : const Center(
                                    child:
                                    CircularProgressIndicator(),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ]),
                  //                                                                                                      // END
                  const SizedBox(height: TSizes.spaceBtwSections),
                  /// Checkout button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Check Out'))),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  /// Description
                  // const TSectionHeading(title: 'Description', showActionButton: false),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                          title: 'Description', showActionButton: false),
                      IconButton(
                          icon: const Icon(Iconsax.arrow_right_3, size: 18),
                          onPressed: () => Get.to(
                                  () => ProductDescriptionScreen(widget.product))),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  /// Reviews
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                          title: 'Reviews', showActionButton: false),
                      IconButton(
                          icon: const Icon(Iconsax.arrow_right_3, size: 18),
                          onPressed: () => Get.to(() =>
                              ProductReviewsScreen(widget.product['id']))),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReviewScreen(
                    widget.product['id'],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const Divider(),
                  TextButton(
                    onPressed: () =>
                        Get.to(() => HomeShopScreen(widget.product['shop'])),
                    child: ShopTitle(widget.product['shop'])
                  ),
                  const Divider(),
                  const TSectionHeading(
                      title: 'Product difference for Shop',
                      showActionButton: false),
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

// Handle Data
//product_detail_image_slider.dart
List listImage = [];
Future<List> _loadDataImage(int id) async {
  listImage = await ProductColorAPI.getListProductColorByProductID(id);
  return listImage;
}

String checkImage(List listImage, int id) {
  if (id == 0) {
    return listImage[0]['image'];
  } else {
    for (var data in listImage) {
      if (data['color']['id'] == id) {
        return data['image'];
      }
    }
  }
  return '';
}
