import '../model/order_detail.dart';
import '../utils/http/http_client.dart';
class OrderDetailAPI {
  static dynamic getOrderDetails(){
    return THttpHelper.get('order_detail/all');
  }
  static dynamic getOrderDetailByID(int id){
    return THttpHelper.get('order_detail/detail?id=$id');
  }
  static dynamic getOrderDetailByOrderID(int orderID){
    return THttpHelper.get('order_detail/byOrderID?orderID=$orderID');
  }
  static dynamic getSumOrderDetailByOrderID(int orderID){
    return THttpHelper.get('order_detail/sumByOrderID?orderID=$orderID');
  }
  static dynamic getOrderDetailByOrderIDAndProductDetailID(int orderID, int productDetailID){
    return THttpHelper.get('order_detail/byOrderID_ProductDetailID?orderID=$orderID&productDetailID=$productDetailID');
  }
  static dynamic getOrderDetailByShopIDAndOrderID(int shopID, int orderID){
    return THttpHelper.get('order_detail/byShopID_OrderID?shopID=$shopID&orderID=$orderID');
  }
  static dynamic getOrderDetailByOrderIDAndProductID(int orderID, int productID){
    return THttpHelper.get('order_detail/byOrderID_ProductID?orderID=$orderID&productID=$productID');
  }
  static dynamic addOrderDetail(OrderDetail orderDetail){
    return THttpHelper.post('order_detail/create', OrderDetail.toJson(orderDetail));
  }
  static dynamic updateOrderDetail(OrderDetail orderDetail){
    return THttpHelper.put('order_detail/update', OrderDetail.toJson(orderDetail));
  }
  static dynamic deleteOrderDetailByID(int id){
    return THttpHelper.delete('order_detail/delete?id=$id');
  }
}
