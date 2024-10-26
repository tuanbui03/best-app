import 'package:best/api/product_detail_api.dart';
import 'package:best/api/wishlist_api.dart';

import '../../api/order_api.dart';
import '../../api/order_detail_api.dart';
import '../../api/shop_api.dart';
import '../../model/order.dart';
import '../../model/order_detail.dart';
import '../../model/wishlist.dart';

class DataApp {
  static dynamic user = 0;
  static dynamic product = "";
  static List<int> listQuantityProduct = List.filled(20, 0);
  static int indexQuantityProduct = -1;
  static List<String> listImageProduct = List.filled(10, '');
  static List listCategory = [];
  static List listBrand = [];
  static int indexImageProduct = -1;
  // static dynamic userFeedback = "";
  static dynamic orderId;
  static dynamic voucherID;
  static dynamic voucher_discount;
  static dynamic mapQuantitySold;
  static dynamic sumProduct;
  static dynamic sumProductCart;
  static dynamic imageColorID;
  // static dynamic listBrand ;
  static Order order = Order(0, 0, 0, '', 0, '', '', 1);
  static int indexPaymentID = 0;
  static dynamic textFind = "";
  static dynamic total = 0;
  static dynamic sizeID = 0;
  static dynamic colorID = 0;
  static Map<int, int> mapShopNameID = {};
  static dynamic stateShop = false;

  static dynamic setCart() async {
    try {
      dynamic orderAction =
          await OrderAPI.getOrderAction(DataApp.user['id']);
      DataApp.orderId = orderAction['id'];
    } on Exception catch (_) {
      Order db = Order(0, DataApp.user['id'], 1, '', 0, '', '',1);
      await OrderAPI.addOrder(db);
      dynamic result = await OrderAPI.getOrderAction(DataApp.user['id']);
      DataApp.orderId = result['id'];
    }
  }
//wishlist
  static void saveWishlist(Wishlist wishlist) async {
    await WishlistAPI.addWishlist(wishlist);
  }

  static void deleteWishlist(int wishlistID) async {
    await WishlistAPI.deleteWishlistByID(wishlistID);
  }

  static dynamic checkProductWishlist(int userID, int productID, bool isLike) async{
    try {
      dynamic ob = await WishlistAPI.getWishlistByUserIDAndProductID(userID,productID);
      if(isLike == false){
      deleteWishlist(ob['wishlistID']);}
    } on Exception catch (_) {
      Wishlist wishlist = Wishlist(
          0,
          productID,
          userID,
          '0',
          '0');
      if (isLike) {
        saveWishlist(wishlist);
      }
    }
  }
  //

  static Future handleCart(dynamic product, int qt ,dynamic discountPercent) async {
    try {
      dynamic productDetail = await ProductDetailAPI.getProductDetailByProductIdAndColorIdAndSizeID(product['id'],DataApp.colorID, DataApp.sizeID);
      dynamic result = await OrderDetailAPI.getOrderDetailByOrderIDAndProductDetailID(DataApp.orderId, productDetail['id']);
      dynamic quantity = result['quantity'] + qt;
      dynamic price =
          product['price'] *
          (100 - product['discount']) /
          100 *
          (100 - int.parse(discountPercent[discountPercent.length - 2])) / 100;
      OrderDetail orderDetail = OrderDetail(
          result['id'],
          DataApp.orderId,
          DataApp.voucherID,
          productDetail['id'],
          quantity,
          price);
      await OrderDetailAPI.updateOrderDetail(orderDetail);
    } on Exception catch (_) {
      dynamic price =
          product['price'] *
          (100 - product['discount']) /
          100 *
          (100 - int.parse(discountPercent[discountPercent.length - 2])) / 100;
      dynamic productDetail = await ProductDetailAPI.getProductDetailByProductIdAndColorIdAndSizeID(product['id'],DataApp.colorID, DataApp.sizeID);
      OrderDetail orderDetail = OrderDetail(
          0,
          DataApp.orderId,
          DataApp.voucherID,
          productDetail['id'],
          qt,
          price);

      await OrderDetailAPI.addOrderDetail(orderDetail);
    }
  }
  //Shop
  static dynamic userShopID = 0;
  static dynamic checkLiveShop() async{
    try {
      DataApp.userShopID = await ShopAPI.getShopByID(DataApp.user['id']);
    } on Exception catch (_) {
      DataApp.userShopID = 0;
      }
  }
}
