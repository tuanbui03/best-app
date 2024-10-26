import 'package:best/api/product_api.dart';
import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:best/common/widgets/texts/section_heading.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatefulWidget {
  dynamic brand;
  BrandProducts(this.brand,{super.key});

  @override
  State<BrandProducts> createState() => _BrandProductsState();
}

class _BrandProductsState extends State<BrandProducts> {
  List listProduct = [];
  Future<List> _loadDataProduct() async {
    listProduct = await ProductAPI.getProductByBrandID(widget.brand['id']);
    return listProduct;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TRoundedImage(height: 150, width: 150,imageUrl: widget.brand['image'], applyImageRadius: true),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text('${widget.brand['name']}',style: const TextStyle(fontSize: 24),),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'Products', onPressed : null, showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems),
              /// Brand Detail
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
      ),
    );
  }
}