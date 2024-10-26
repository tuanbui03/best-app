import 'package:best/utils/http/http_client.dart';
import '../model/message.dart';

class MessageAPI {
  static dynamic getMessages() {
    return THttpHelper.get('message/all');
  }

  static dynamic getMessageByID(int id) {
    return THttpHelper.get('message/detail?id=$id');
  }

  static dynamic addMessage(Message ob) {
    return THttpHelper.post('message/create', Message.toJson(ob));
  }

  static dynamic updateMessage(Message ob) {
    return THttpHelper.put('message/update', Message.toJson(ob));
  }

  static dynamic deleteMessageByID(int id) {
    return THttpHelper.delete('message/delete?id=$id');
  }
}
