import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatelessWidget{
  dynamic product;
  ProductDescriptionScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      /// Appbar
      appBar: const TAppBar(title: Text('Description')),
      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(product['description']),
            ],
          )
            )
        ),
    );
  }
}
