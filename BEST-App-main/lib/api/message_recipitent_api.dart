import 'package:best/utils/http/http_client.dart';
import '../model/message_recipient.dart';

class MessageRecipientAPI {
  static dynamic getMessageRecipients() {
    return THttpHelper.get('message_recipient/all');
  }

  static dynamic getMessageRecipientByID(int id) {
    return THttpHelper.get('message_recipient/detail?id=$id');
  }

  static dynamic addMessageRecipient(MessageRecipient ob) {
    return THttpHelper.post('message_recipient/create', MessageRecipient.toJson(ob));
  }

  static dynamic updateMessageRecipient(MessageRecipient ob) {
    return THttpHelper.put('message_recipient/update', MessageRecipient.toJson(ob));
  }

  static dynamic deleteMessageRecipientByID(int id) {
    return THttpHelper.delete('message_recipient/delete?id=$id');
  }
}
