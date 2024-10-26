import 'package:best/api/product_api.dart';
import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatefulWidget {
  dynamic category;
  SubCategoriesScreen(this.category, {super.key});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  List listProductByCategory = [];
  Future<List> _loadDataProductByCategoryID(int categoryID) async {
    listProductByCategory = await ProductAPI.getProductByCategoryID(categoryID);
    return listProductByCategory;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(title: Text('${widget.category['name']}'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:
          Column(
            children: [
              /// Banner
              TRoundedImage(imageUrl: widget.category['image'], applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwSections),
              /// Sub Categories
              Column(
                children: [
                  /// Heading
                  TSectionHeading(title: 'Product', onPressed: (){}),
                  const SizedBox(height: TSizes.spaceBtwItems / 2),
                  // const TProductCardHorizontal(),
                  FutureBuilder(
                      future: _loadDataProductByCategoryID(widget.category['id']),
                      builder:
                          (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? TGridLayout(
                        itemCount: listProductByCategory.length,
                        itemBuilder: (_, index) =>
                            TProductCardVertical(
                                snapshot.data![index], false),
                      )
                          : const Center(
                        child: CircularProgressIndicator(),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}