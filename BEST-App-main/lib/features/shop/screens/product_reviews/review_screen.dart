import 'package:best/api/feedback_api.dart';
import 'package:best/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:best/features/shop/screens/product_reviews/widgets/user_reviews.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
class ReviewScreen extends StatelessWidget{
  dynamic productID;
  ReviewScreen(this.productID, {super.key});

//Handle Data
  List listFeedback = [];
  Future<List> _loadDataFeedbackProduct() async {
      listFeedback = await FeedbackAPI.getFeedbackByProductLimit(productID);
      return listFeedback;
  }

  @override
  Widget build(BuildContext context){
    return  FutureBuilder(
              future: _loadDataFeedbackProduct(),
              builder:
                  (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              listFeedback.isNotEmpty
                  ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and reviews are verified and arr from people who use the same type of device that you use.",style: TextStyle(fontSize: 12),),
              /// Overall Product Ratings
              const SizedBox(height: TSizes.spaceBtwSections),
              for(int i = 0; i < listFeedback.length; i++)
                UserReviewCard(listFeedback[i]),
               ],
          )
             : const Text('There are no reviews yet', textAlign: TextAlign.center,));
  }
}
