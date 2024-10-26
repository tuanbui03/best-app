import 'package:best/common/widgets/custom_shapes/containers/rounded_container.dart';

import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'brand_card.dart';

class TBrandShowCase extends StatelessWidget {
  dynamic brand;
  TBrandShowCase(this.brand,{
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          /// Brand with Products count
           TBrandCard(showBorder: false, brand: brand,),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Brand top 3 products img
          Row(
              children: images
                  .map((image) => brandTopProductImageWidget(image, context))
                  .toList()),
        ],
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
        child: TRoundedContainer(
          height: 100,
          padding: const EdgeInsets.all(TSizes.md),
          margin: const EdgeInsets.only(right: TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context)
              ? TColors.darkerGrey
              : TColors.light,
          child:
          Image(fit: BoxFit.contain, image: AssetImage(image)),
        ));
  }
}
