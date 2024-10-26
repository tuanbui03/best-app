import '../model/product_detail.dart';
import '../utils/http/http_client.dart';

class ProductDetailAPI {
  static dynamic getProductDetails()  {
    return THttpHelper.get('product_detail/all');
  }

  static dynamic getProductDetailByProductIdAndColorIdAndSizeID(int productID, int colorID, int sizeID){
    return THttpHelper.get('product_detail/byProductID_ColorID_SizeID?productID=$productID&colorID=$colorID&sizeID=$sizeID');
  }

  static dynamic getProductDetailByID(int id){
    return THttpHelper.get('product_detail/detail?id=$id');
  }
  static dynamic getProductDetailByShopID(int shopID){
    return THttpHelper.get('product_detail/byShopID?shopID=$shopID');
  }
  static dynamic getProductDetailByShopIDAndProductID(int shopID, int productID){
    return THttpHelper.get('product_detail/byShopID_ProductID?shopID=$shopID&productID=$productID');
  }
  static dynamic getSumProductDetailByColorID(int id){
    return THttpHelper.get('product_detail/byColorID?id=$id');
  }

  static dynamic getSumProductDetailBySizeID(int id){
    return THttpHelper.get('product_detail/bySizeID?id=$id');
  }

  static dynamic getSumProductDetailByColorIAndSizeID(int colorID, int sizeID){
    return THttpHelper.get('product_detail/byColorId_SizeId?colorID=$colorID&sizeID=$sizeID');
  }

  static dynamic addProductDetail(ProductDetail productDetail){
    return THttpHelper.post('product_detail/create', ProductDetail.toJson(productDetail));
  }

  static dynamic updateProductDetail(ProductDetail productDetail){
    return THttpHelper.put('product_detail/update', ProductDetail.toJson(productDetail));
  }

  static dynamic deleteProductDetailByID(int id){
    return THttpHelper.delete('product_detail/delete?id=$id');

  }
}
