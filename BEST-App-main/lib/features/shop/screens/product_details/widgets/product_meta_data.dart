import 'package:best/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:best/common/widgets/images/t_circular_image.dart';
import 'package:best/common/widgets/texts/product_price_text.dart';
import 'package:best/common/widgets/texts/product_title_text.dart';
import 'package:best/common/widgets/texts/t_brand_title_with_verfied_icon.dart';
import 'package:best/utils/constants/colors.dart';
import 'package:best/utils/constants/image_strings.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:best/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants/enums.dart';

class TProductMetaData extends StatelessWidget {
  dynamic product;
  TProductMetaData(this.product);

  @override
  Widget build(BuildContext context) {
    dynamic priceSale =
        product['price'] - product['price'] * product['discount'] / 100;
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Price & Sale Price
        Row(
          children: [
            /// Sale Tag
            TProductPriceText(price: '${priceSale}', isLarge: true),
            const SizedBox(width: TSizes.spaceBtwItems),

            /// Price
            Text('\$${product['price']}',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .apply(decoration: TextDecoration.lineThrough)),

            const SizedBox(width: TSizes.spaceBtwItems),

            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text('-${product['discount']}%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: TColors.black)),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const TProductTitleText(title: 'Status: '),
            Text(' ${(product['status'] == 1)?'Stocking':'Out of stock'}', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            TCircularImage(
              image: TImages.google,
              width: 30,
              height: 30,
              overlayColor: darkMode ? TColors.white : TColors.black,
            ),
            TBrandTitleWithVerifiedIcon(
                title: '${product['shop']['address']}', brandTextSize: TextSize.medium),
          ],
        ),
      ],
    );
  }
}
