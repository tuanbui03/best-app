import 'package:best/utils/http/http_client.dart';
import '../model/brand.dart';

class BrandAPI {
  static dynamic getBrands() {
    return THttpHelper.get('brand/all');
  }

  static dynamic getBrandByID(int id) {
    return THttpHelper.get('brand/detail?id=$id');
  }

  static dynamic addBrand(Brand brand) {
    return THttpHelper.post('brand/create', Brand.toJson(brand));
  }

  static dynamic updateBrand(Brand brand) {
    return THttpHelper.put('brand/update', Brand.toJson(brand));
  }

  static dynamic deleteBrandByID(int id) {
    return THttpHelper.delete('brand/delete?id=$id');
  }
}
