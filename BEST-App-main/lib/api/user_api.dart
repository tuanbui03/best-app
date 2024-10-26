import '../model/user.dart';
import '../utils/http/http_client.dart';

class UserAPI {
  static dynamic loginUser(String email, String password){
    return THttpHelper.get('login_user?email=$email&password=$password');
  }

  static dynamic getUsers() {
    return THttpHelper.get('user/all');
  }

  static dynamic getUserByID(int id) {
    return THttpHelper.get('user/detail?id=$id');
  }

  static dynamic getUserByEmail(String email) {
    return THttpHelper.get('user/byEmail?email=$email');
  }
  static dynamic addUser(Users user) {
    return THttpHelper.post('user/create', Users.toJson(user));
  }

  static dynamic updateUser(Users user) {
    return THttpHelper.put('user/update', Users.toJson(user));
  }

  static dynamic deleteUserByID(int id) {
    return THttpHelper.delete('user/delete?id=$id');
  }

}
