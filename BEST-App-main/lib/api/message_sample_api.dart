import 'package:best/utils/http/http_client.dart';
import '../model/message_sample.dart';

class MessageSampleAPI {
  static dynamic getMessageSamples() {
    return THttpHelper.get('message_sample/all');
  }

  static dynamic getMessageSampleByID(int id) {
    return THttpHelper.get('message_sample/detail?id=$id');
  }

  static dynamic addMessageSample(MessageSample ob) {
    return THttpHelper.post('message_sample/create', MessageSample.toJson(ob));
  }

  static dynamic updateMessageSample(MessageSample ob) {
    return THttpHelper.put('message_sample/update', MessageSample.toJson(ob));
  }

  static dynamic deleteMessageSampleByID(int id) {
    return THttpHelper.delete('message_sample/delete?id=$id');
  }
}
