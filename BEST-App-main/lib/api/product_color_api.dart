import '../model/product_color.dart';
import '../utils/http/http_client.dart';

class ProductColorAPI {
  static dynamic getProductColors(){
    return THttpHelper.get('product_color/all');
  }

  static dynamic getProductColorByID(int id){
    return THttpHelper.get('product_color/detail?id=$id');
  }

  static dynamic getListProductColorByProductID(int id){
    return THttpHelper.get('product_color/byProductID?id=$id');
  }

  static dynamic getListProductColorByProductIdAndColorID(int productID, int colorID){
    return THttpHelper.get('product_color/byProductIdAndColorID?productID=$productID&colorID=$colorID');
  }

  static dynamic addProductColor(ProductColor productColor){
    return THttpHelper.post('product_color/create', ProductColor.toJson(productColor));
  }

  static dynamic updateProductColor(ProductColor productColor){
    return THttpHelper.put('product_color/update', ProductColor.toJson(productColor));
  }

  static dynamic deleteProductColorByID(int id){
    return THttpHelper.delete('product_color/delete?id=$id');
  }
}
