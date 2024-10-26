import 'package:best/utils/http/http_client.dart';
import '../model/shop.dart';

class ShopAPI {
  static dynamic getShops() {
    return THttpHelper.get('shop/all');
  }
  static dynamic getShopBySearchName(String text) {
    return THttpHelper.get('shop/search?name=$text');
  }
  static dynamic getShopByID(int id) {
    return THttpHelper.get('shop/detail?id=$id');
  }
  static dynamic addShop(Shop shop) {
    return THttpHelper.post('shop/create', Shop.toJson(shop));
  }

  static dynamic updateShop(Shop shop) {
    return THttpHelper.put('shop/update', Shop.toJson(shop));
  }

  static dynamic deleteShopByID(int id) {
    return THttpHelper.delete('shop/delete?id=$id');
  }
}
