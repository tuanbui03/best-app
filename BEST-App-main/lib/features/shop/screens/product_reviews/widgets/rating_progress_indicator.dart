import 'package:best/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/products/ratings/rating_indicator.dart';

class TOverallProductRating extends StatelessWidget {
  List listCountVote;
  dynamic vote;
  dynamic totalVote;
   TOverallProductRating({
    super.key, this.vote, this.totalVote, required this.listCountVote
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$vote', style: Theme.of(context).textTheme.displayLarge),
            TRatingBarIndicator(rating: vote),
            Text('$totalVote', style: Theme.of(context).textTheme.bodySmall),
          ],
        )),// code check
         Expanded(
          flex: 7,
          child: Column(
            children: [
              for(int i = 5; i > 0; i--)
                TRatingProgressIndicator(text: '$i', value: listCountVote[i]),
            ],
          ),
        )

      ],
    );
  }
}
