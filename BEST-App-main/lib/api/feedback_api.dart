import '../model/feedback.dart';
import '../utils/http/http_client.dart';

class FeedbackAPI {
  static dynamic getFeedbacks()  {
    return THttpHelper.get('feedback/all');
  }

  static dynamic getFeedbackByID(int id) async {
    return THttpHelper.get('feedback/detail?id=$id');
  }

  static dynamic getFeedbackByProductID(int productID) async {
    return THttpHelper.get('feedback/byProduct?productID=$productID');
  }
  static dynamic getFeedbackByProductLimit(int productID) async {
    return THttpHelper.get('feedback/byProductLimit?productID=$productID');
  }
  static dynamic getFeedbackByShopID(int shopID) async {
    return THttpHelper.get('feedback/byShop?shopID=$shopID');
  }

  static dynamic getFeedbackByProductIdAndUserID(int productID, int userID) async {
    return THttpHelper.get('feedback/byProductIdAndUserID?productID=$productID&userID=$userID');
  }

  static dynamic addFeedback(Feedbacks feedback) async {
    return THttpHelper.post('feedback/create', Feedbacks.toJson(feedback));

  }

  static dynamic updateFeedback(Feedbacks feedback) async {
    return THttpHelper.put('feedback/update', Feedbacks.toJson(feedback));
  }

  static dynamic deleteFeedbackByID(int id) async {
    return THttpHelper.delete('feedback/delete?id=$id');

  }
}
