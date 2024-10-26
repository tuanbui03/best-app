class Feedbacks {
  final int id;
  final int userId;
  final int productId;
  final String content;
  final int vote;
  final String createdAt;

  Feedbacks(this.id, this.userId, this.productId, this.content, this.vote, this.createdAt);

  static Map<String, dynamic> toJson(Feedbacks feedbacks) {
    return {
      'id': feedbacks.id,
      'user_id': feedbacks.userId,
      'product_id': feedbacks.productId,
      'content': feedbacks.content,
      'vote': feedbacks.vote,
      'createdAt': feedbacks.createdAt,
    };
  }
}
