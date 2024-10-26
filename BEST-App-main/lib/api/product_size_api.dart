import '../model/product_size.dart';
import '../utils/http/http_client.dart';

class ProductSizeAPI {
  static dynamic getProductSizes(){
    return THttpHelper.get('product_size/all');
  }

  static dynamic getProductSizeByID(int id){
    return THttpHelper.get('product_size/detail?id=$id');
  }

  static dynamic getProductSizeByProductIdAndSizeID(int productID,int sizeID){
    return THttpHelper.get('product_size/byProductID_SizeID?productID=$productID&sizeID=$sizeID');
  }

  static dynamic getProductSizeByProductID(int id){
    return THttpHelper.get('product_size/byProduct?productID=$id');
  }

  static dynamic addProductSize(ProductSize productSize){
    return THttpHelper.post('product_size/create', ProductSize.toJson(productSize));
  }

  static dynamic updateProductSize(ProductSize productSize){
    return THttpHelper.post('product_size/create', ProductSize.toJson(productSize));
  }

  static dynamic deleteProductSizeByID(int id){
    return THttpHelper.delete('product_size/delete?id=$id');
  }
}
