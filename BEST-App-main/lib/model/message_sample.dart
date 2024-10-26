class MessageSample {
  final int id;
  final int shopId;
  final String question;
  final String answer;

  MessageSample(this.id, this.shopId, this.question, this.answer);

  static Map<String, dynamic> toJson(MessageSample ob) {
    return {
      'id': ob.id,
      'shop_id': ob.shopId,
      'question': ob.question,
      'answer': ob.answer
    };
  }
}
