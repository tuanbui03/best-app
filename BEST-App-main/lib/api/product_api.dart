import '../model/product.dart';
import '../utils/http/http_client.dart';

class ProductAPI {
  static dynamic getProducts(){
    return THttpHelper.get('product/all');
  }

  static dynamic getProductAction(){
    return THttpHelper.get('product/action');
  }
  static dynamic getProductName(){
    return THttpHelper.get('product/name');
  }
  static dynamic getProductHeightPrice(){
    return THttpHelper.get('product/height_price');
  }
  static dynamic getProductLowPrice(){
    return THttpHelper.get('product/low_price');
  }
  static dynamic getProductSale(){
    return THttpHelper.get('product/sale');
  }
  static dynamic getProductNew(){
    return THttpHelper.get('product/new');
  }
  static dynamic getProductPopular(){
    return THttpHelper.get('product/popular');
  }
  static dynamic getProductByID(int id){
    return THttpHelper.get('product/detail?id=$id');
  }
  static dynamic getProductRemain(int shopID, int productID){
    return THttpHelper.get('product/remain?shopID=$shopID&productID=$productID');
  }
  static dynamic getProductByCategoryID(int id){
    return THttpHelper.get('product/byCategory?categoryID=$id');
  }

  static dynamic getProductByBrandID(int id){
    return THttpHelper.get('product/byBrand?brandID=$id');
  }

  static dynamic getProductByShopID(int id){
    return THttpHelper.get('product/byShop?shopID=$id');
  }

  static dynamic getProductBySearch(String textSearch){
    return THttpHelper.get('product/search?text=$textSearch');
  }

  static dynamic addProduct(Product product){
    return THttpHelper.post('product/create', Product.toJson(product));
  }

  static dynamic updateProduct(Product product){
    return THttpHelper.put('product/update', Product.toJson(product));
  }

  static dynamic deleteProductByID(int id){
    return THttpHelper.delete('product/delete?id=$id');
  }
}
