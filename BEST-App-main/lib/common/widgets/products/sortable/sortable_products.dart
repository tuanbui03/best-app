import 'package:best/api/product_api.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cart/product_cart_vertical.dart';

class TSortableProducts extends StatefulWidget {
  const TSortableProducts({super.key});

  @override
  State<TSortableProducts> createState() => _TSortableProductsState();
}

class _TSortableProductsState extends State<TSortableProducts> {
  List listProduct = [];
  String itemName = '';
  List listDropdown = ['Name',
    'Higher Price',
    'Low Price',
    'Sale',
    'Newest',
    'Popularity'];
  Future<List> _loadDataProduct(String item) async {
    listProduct.clear();
    if(item == listDropdown[0]){
      listProduct = await ProductAPI.getProductName();
    }else if(item == listDropdown[1]){
      listProduct = await ProductAPI.getProductHeightPrice();
    }else if(item == listDropdown[2]){
      listProduct = await ProductAPI.getProductLowPrice();
    }else if(item == listDropdown[3]){
      listProduct = await ProductAPI.getProductSale();
    }else if(item == listDropdown[4]){
      listProduct = await ProductAPI.getProductNew();
    }else {
      listProduct = await ProductAPI.getProductPopular();
    }
    return listProduct;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.sort),
          ),
          onChanged: (value) {
            itemName = value.toString();
            setState(() {
            });
            },
          items: [
            for(final data in listDropdown)
              '$data',
          ]
              .map((option) =>
              DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Products
        FutureBuilder(
            future: _loadDataProduct(itemName),
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
    );
  }
}
