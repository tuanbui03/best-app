import 'package:best/api/feedback_api.dart';
import 'package:best/api/product_api.dart';
import 'package:best/api/voucher_api.dart';
import 'package:best/api/warehouse_voucher_api.dart';
import 'package:best/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:best/common/widgets/layouts/grid_layout.dart';
import 'package:best/common/widgets/products/product_cart/product_cart_vertical.dart';
import 'package:best/common/widgets/texts/t_brand_title_with_verfied_icon.dart';
import 'package:best/utils/global_variable/dataApp.dart';
import 'package:best/features/shop/screens/store/page/widgets/shop_title.dart';
import 'package:best/model/warehouse_voucher.dart';
import 'package:best/utils/constants/enums.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

Map<int, String> mapCategory = {};

class HomeShopScreen extends StatefulWidget {
  dynamic dataShop;

  HomeShopScreen(this.dataShop, {super.key});

  @override
  State<HomeShopScreen> createState() => _HomeShopScreenState();
}

class _HomeShopScreenState extends State<HomeShopScreen> {
  //voucher by shop
  List listObs = [];
  Future<List> _loadData() async {
    listObs = await VoucherAPI.getVoucherByShopID(widget.dataShop['id']);
    return listObs;
  }

  //product by shop
  List listProduct = [];
  Future<List> _loadDataProduct() async {
    listProduct = await ProductAPI.getProductByShopID(widget.dataShop['id']);
    for (final data in listProduct) {
      Map<int, String> map = {data['category']['id']: data['category']['name']};
      mapCategory.addEntries(map.entries);
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 110,
          title: TextButton(
            onPressed: () {},
            child: ShopTitle(widget.dataShop)
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Voucher',
              ),
              Tab(
                text: 'Product',
              ),
              Tab(
                text: 'Category',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: FutureBuilder(
                  future: _loadData(),
                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                  snapshot.hasData
                      ? Column(
                    children: [
                      const Text('\n'),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      TGridLayout(
                        itemCount: snapshot.data!.length,
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
                                          '${snapshot.data![index]['code']}',
                                          brandTextSize:
                                          TextSize.large),
                                      Row(
                                        children: [
                                          Text(
                                            'Sale ${snapshot.data![index]['discount_percent']}%',
                                            overflow:
                                            TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                          const Text(
                                              '                     '),
                                          TextButton(
                                              onPressed: () async {
                                                WarehouseVoucher ob =
                                                WarehouseVoucher(
                                                    0,
                                                    DataApp.user[
                                                    'id'],
                                                    snapshot.data![
                                                    index]
                                                    ['id']);
                                                await WarehouseVoucherAPI
                                                    .addWarehouseVoucher(
                                                    ob);
                                                setState(() {
                                                  build(context);
                                                });
                                              },
                                              child: const Text(
                                                'Add',
                                              )),
                                        ],
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
                      : const Text('')),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Popular New '),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder(
                      future: _loadDataProduct(),
                      builder:
                          (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                      snapshot.hasData
                          ? const Text('Category')
                          : const Center(
                        child: CircularProgressIndicator(),
                      )),
                  Text('$mapCategory'),
                  for (MapEntry<int, String> e in mapCategory.entries)
                    TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            Text('${e.key} :  ${e.value}'),
                          ],
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
