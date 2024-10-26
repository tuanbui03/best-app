import 'package:best/api/feedback_api.dart';
import 'package:best/api/product_api.dart';
import 'package:flutter/material.dart';

class ShopTitle extends StatelessWidget {
  dynamic dataShop;
  double vote = 0;
  ShopTitle(this.dataShop, {super.key});
  //information by shop
  List listDataAmountProduct = [];
  List listDataAmountVote = [];
  Future<List> _loadDataShop() async {
    listDataAmountProduct = await ProductAPI.getProductByShopID(dataShop['id']);
    listDataAmountVote = await FeedbackAPI.getFeedbackByShopID(dataShop['id']);
    for(final data in listDataAmountVote){
      vote += data['vote'];
    }
    vote /= listDataAmountVote.length;
    return listDataAmountProduct;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image(
              image: AssetImage(dataShop['image']),
              height: 70.0,
              width: 70.0,
              fit: BoxFit.fill,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '   ${dataShop['name']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
               Row(
                 children: [
                   const Text('   '),
                   const Icon(Icons.fmd_good_outlined, size: 16),
                   Text('${dataShop['address']}'),
                 ],
               )
              ],
            ),
          ],
        ),
        FutureBuilder(
            future: _loadDataShop(),
            builder:
                (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
            snapshot.hasData
                ? Text.rich(TextSpan(children: [
              TextSpan(
                text: '  ${listDataAmountProduct.length} ',
                style: const TextStyle(color: Colors.red),),
              const TextSpan(
                  text: 'Product    ',style: TextStyle(color: Colors.black)),
              TextSpan(
                text: '${vote.toStringAsFixed(1)} ',
                style: const TextStyle(color: Colors.red),),
              const TextSpan(
                  text: 'Vote    ',style: TextStyle(color: Colors.black)),
              const TextSpan(
                text: '96% ',
                style: TextStyle(color: Colors.red),),
              const TextSpan(
                  text: 'Chat Response',style: TextStyle(color: Colors.black)),
            ])):const Text(''))
      ],
    );
  }
}
