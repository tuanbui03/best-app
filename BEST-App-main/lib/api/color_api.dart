import '../model/color.dart';
import '../utils/http/http_client.dart';

class ColorAPI {
  static dynamic getColors(){
    return THttpHelper.get('color/all');
  }

  static dynamic getColorByID(int id){
    return THttpHelper.get('color/detail?id=$id');
  }

  static dynamic addColor(Colorss color){
    return THttpHelper.post('color/create', Colorss.toJson(color));
  }

  static dynamic updateColor(Colorss colors){
    return THttpHelper.put('color/update', Colorss.toJson(colors));
  }

  static dynamic deleteColorByID(int id){
    return THttpHelper.delete('color/delete?id=$id');
  }
}
