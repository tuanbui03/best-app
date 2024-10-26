import '../model/wishlist.dart';
import '../utils/http/http_client.dart';

class WishlistAPI {

  static dynamic getWishlistByUserID(int id) async {
    return THttpHelper.get('wishlist/userID?id=$id');
  }

  static dynamic getWishlistByShopID(int id) async {
    return THttpHelper.get('wishlist/byShop?shopID=$id');
  }

  static dynamic getWishlistByUserIDAndProductID(
      int userID, int productID) async {
    return THttpHelper.get('wishlist/u_p?userID=$userID&productID=$productID');
  }

  static dynamic getWishlists() {
    return THttpHelper.get('wishlist/all');
  }

  static dynamic getWishlistByID(int id) {
    return THttpHelper.get('wishlist/detail?id=$id');
  }

  static dynamic addWishlist(Wishlist wishlist) {
    return THttpHelper.post('wishlist/create', Wishlist.toJson(wishlist));
  }

  static dynamic updateWishlist(Wishlist wishlist) {
    return THttpHelper.put('wishlist/update', Wishlist.toJson(wishlist));
  }

  static dynamic deleteWishlistByID(int id) {
    return THttpHelper.delete('wishlist/delete?id=$id');
  }

}
