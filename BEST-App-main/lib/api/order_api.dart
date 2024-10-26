import '../model/order.dart';
import '../utils/http/http_client.dart';

class OrderAPI {
  static dynamic getOrders() async {
    return THttpHelper.get('order/all');
  }

  static dynamic getOrderByID(int id) async {
    return THttpHelper.get('order/detail?id=$id');
  }
  static dynamic getOrderByShopID(int shopID) async {
    return THttpHelper.get('order/byShop?shopID=$shopID');
  }
  static dynamic getSumProductSold(int id) async {
    return THttpHelper.get('order/sumQuantityProduct?productID=$id');
  }

  static dynamic getOrderAction(int userID) async {//find cart action -> Object
    return THttpHelper.get('order/action?userID=$userID');
  }

    static dynamic getOrderDisAction(int userID) async {// find history -> List<Object>
    return THttpHelper.get('order/disAction?userID=$userID');
    }

  static dynamic addOrder(Order order) async {
    return THttpHelper.post('order/create', Order.toJson(order));
  }

  static dynamic updateOrder(Order order) async {
    return THttpHelper.put('order/update', Order.toJson(order));
  }

  static dynamic deleteOrderByID(int id) async {
    return THttpHelper.delete('order/delete?id=$id');
  }

}
