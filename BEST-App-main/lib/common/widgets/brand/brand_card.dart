import 'package:best/api/product_api.dart';
import 'package:best/common/widgets/images/t_rounded_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/containers/rounded_container.dart';
import '../texts/t_brand_title_with_verfied_icon.dart';

class TBrandCard extends StatelessWidget {
  final brand;
  TBrandCard({this.brand,
    super.key,
    this.onTap,
    required this.showBorder,
  });

  final bool showBorder;
  final void Function()? onTap;
  List listProduct = [];
  Future<List> _loadDataProduct() async {
    listProduct = await ProductAPI.getProductByBrandID(brand['id']);
    return listProduct;
  }
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// Icon
            // Flexible(
            //   child: TCircularImage(
            //     isNetworkImage: false,
            //     image: TImages.verifyIllustration,
            //     backgroundColor: Colors.transparent,
            //     overlayColor: isDark ? TColors.white : TColors.black,
            //   ),
            // ),
            Expanded(child: TRoundedImage(imageUrl: brand['image'], applyImageRadius: true)),

            const SizedBox(width: TSizes.spaceBtwItems / 2),

            /// Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   TBrandTitleWithVerifiedIcon(
                      title: '${brand['name']}', brandTextSize: TextSize.large),
              FutureBuilder(
                future: _loadDataProduct(),
                builder:
                    (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ?
                  Text(
                    '${listProduct.length} products',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ):Text(''))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
