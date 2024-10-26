import '../model/size.dart';
import '../utils/http/http_client.dart';

class SizeAPI {
  static dynamic getSizes() {
    return THttpHelper.get('size/all');
  }

  static dynamic getSizeByID(int id) {
    return THttpHelper.get('size/detail?id=$id');
  }

  static dynamic addSize(Sizes size) {
    return THttpHelper.post('size/create', Sizes.toJson(size));
  }

  static dynamic updateSize(Sizes size) {
    return THttpHelper.put('size/update', Sizes.toJson(size));
  }

  static dynamic deleteSizeByID(int id) {
    return THttpHelper.delete('size/delete?id=$id');
  }
}
