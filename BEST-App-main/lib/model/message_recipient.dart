class MessageRecipient {
  final int id;
  final int messageId;
  final int userId;

  MessageRecipient(this.id, this.messageId, this.userId);

  static Map<String, dynamic> toJson(MessageRecipient ob) {
    return {
      'id': ob.id,
      'message_id': ob.messageId,
      'user_id': ob.userId
    };
  }
}
