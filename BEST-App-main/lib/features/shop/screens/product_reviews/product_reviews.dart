import 'package:best/api/feedback_api.dart';
import 'package:best/common/widgets/appbar/appbar.dart';
import 'package:best/features/shop/screens/product_reviews/widgets/user_reviews.dart';
import 'package:best/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget{
  dynamic productID;
  ProductReviewsScreen(this.productID, {super.key});

//Handle Data
  dynamic vote = 0;
  List listFeedback = [];
  List listCountVote = [0,0,0,0,0,0];

  Future<List> _loadDataFeedbackProduct(int productID) async {
    try {
      listFeedback = await FeedbackAPI.getFeedbackByProductID(productID);
      for (var data in listFeedback) {
        switch (data['vote']) {
          case 1:
            listCountVote[1]++;
            break;
          case 2:
            listCountVote[2]++;
            break;
          case 3:
            listCountVote[3]++;
            break;
          case 4:
            listCountVote[4]++;
            break;
          default :
            listCountVote[5]++;
            break;
        }
        vote += data['vote'];
      }
      for (int i = 1; i <= 5; i++) {
        listCountVote[i] /= listFeedback.length;
      }
      vote /= listFeedback.length;
      return listFeedback;
    } on Exception catch (_) {
      return listFeedback;
    }
  }


  @override
  Widget build(BuildContext context){
    return  Scaffold(appBar: const TAppBar(title: Text('Reviews & Ratings')),
      body:
      SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child:
          FutureBuilder(
              future: _loadDataFeedbackProduct(productID),
              builder:
                  (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("All",style: TextStyle(fontSize: 18),),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Overall Product Ratings
              // TOverallProductRating(vote: vote, listCountVote: listCountVote,),
              //TRatingBarIndicator(rating: vote),
              // Text('${listFeedback.length}', style: Theme.of(context).textTheme.bodySmall), //code check
              const SizedBox(height: TSizes.spaceBtwSections),
               ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) =>
                        UserReviewCard(snapshot.data![index]),
                  )
            ],
          )
             : const Center(
              child: CircularProgressIndicator(),
        ))
    )),);
  }
}
