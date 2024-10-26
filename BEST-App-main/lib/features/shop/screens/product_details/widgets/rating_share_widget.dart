import 'package:best/utils/global_variable/dataApp.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../api/feedback_api.dart';
import '../../../../../utils/constants/sizes.dart';

class TRatingAndShare extends StatelessWidget {
  dynamic product;

  TRatingAndShare(this.product, {super.key});

  List listFeedback = [];
  dynamic vote = 0;
  Future<List> _loadDataFeedbackProduct(int productID) async {
    listFeedback = await FeedbackAPI.getFeedbackByProductID(productID);
    for(var data  in listFeedback) {
      vote += data['vote'];
    }
    vote /= listFeedback.length;
    return listFeedback;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FutureBuilder(
            future: _loadDataFeedbackProduct(product['id']),
            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? Row(
                        children: [
                          const Icon(Iconsax.star5,
                              color: Colors.amber, size: 22),
                          const SizedBox(width: TSizes.spaceBtwItems / 2),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: '${vote.toStringAsFixed(1)}',
                                style: Theme.of(context).textTheme.bodyLarge),
                            TextSpan(text: '(${snapshot.data!.length})'),
                          ]))
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )),

        /// Share
        Text((DataApp.mapQuantitySold[product['id']] == 0)? '': 'Sold : ${DataApp.mapQuantitySold[product['id']]}')
      ],
    );
  }
}
