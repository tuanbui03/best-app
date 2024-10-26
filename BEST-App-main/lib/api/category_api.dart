import '../model/category.dart';
import '../utils/http/http_client.dart';

class CategoryAPI {
  static dynamic getAllCategory(){
    return THttpHelper.get('category/all');
  }

  static dynamic getCategoryByID(int id){
    return THttpHelper.get('category/detail?id=$id');
  }

  static dynamic addCategory(Categories category){
    return THttpHelper.post('category/create', Categories.toJson(category));
  }

  static dynamic updateCategory(Categories category){
    return THttpHelper.put('category/update', Categories.toJson(category));
  }

  static dynamic deleteCategoryByID(int id){
    return THttpHelper.delete('category/delete?id=$id');
  }
}
