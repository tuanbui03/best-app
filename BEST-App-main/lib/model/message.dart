class Message {
  final int id;
  final int userId;
  final int messageSampleId;
  final String dateSent;
  final String dateRead;
  final String content;

  Message(this.id, this.userId, this.messageSampleId, this.dateSent, this.dateRead, this.content);

  static Map<String, dynamic> toJson(Message ob) {
    return {
      'id': ob.id,
      'user_id': ob.userId,
      'message_sample_id': ob.messageSampleId,
      'date_sent': ob.dateSent,
      'date_read': ob.dateRead,
      'content': ob.content
    };
  }
}
