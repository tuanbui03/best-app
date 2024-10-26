import 'package:best/api/warehouse_voucher_api.dart';
import 'package:best/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/common/widgets/texts/t_brand_title_with_verfied_icon.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/utils/constants/enums.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class WarehouseVoucherScreen extends StatefulWidget {
  dynamic listData;
  WarehouseVoucherScreen(this.listData,{super.key});

  @override
  State<WarehouseVoucherScreen> createState() => _WarehouseVoucherScreenState();
}
class _WarehouseVoucherScreenState extends State<WarehouseVoucherScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'),),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: SingleChildScrollView(
              child:
              Column(
                    children: [
                      const Text('\n'),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      TGridLayout(
                        itemCount: widget.listData.length,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) => GestureDetector(
                          child: TRoundedContainer(
                            padding: const EdgeInsets.all(TSizes.sm),
                            showBorder: true,
                            backgroundColor: Colors.transparent,
                            child: Row(
                              children: [
                                /// Icon
                                // TRoundedImage(imageUrl: brand['image'], applyImageRadius: true),
                                const SizedBox(
                                    width: TSizes.spaceBtwItems),

                                /// Text
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      TBrandTitleWithVerifiedIcon(
                                          title:
                                          '${widget.listData[index]['voucher']['code']}',
                                          brandTextSize:
                                          TextSize.large),
                                          Expanded(
                                            child: Text(
                                              '${widget.listData[index]['voucher']['product']['name']}',
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                                                                  ),
                                          ),
                                      Text(
                                        'Sale ${widget.listData[index]['voucher']['discount_percent']}%',
                                        overflow:
                                        TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
            ),
        ),
      ),
    );
  }
}