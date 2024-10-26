import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/common/widgets/brand/brand_card.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/brand/brand_products.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBrandScreen extends StatelessWidget {
  dynamic listBrand;
  AllBrandScreen(this.listBrand,{super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(title: Text('Brands'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Heading
              const SizedBox(height: TSizes.spaceBtwItems),
              /// Brands
              TGridLayout(
                itemCount: listBrand.length,
                mainAxisExtent: 80,
                itemBuilder: (context, index) =>
                    TBrandCard(showBorder: true,brand: listBrand[index],
                      onTap: () => Get.to(() =>  BrandProducts(listBrand[index])),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
