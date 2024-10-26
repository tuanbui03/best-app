class Wishlist {
  final int id;
  final int productId;
  final int userId;
  final String createdAt;
  final String updatedAt;

  Wishlist(this.id, this.productId, this.userId, this.createdAt,
      this.updatedAt);

  static Map<String, dynamic> toJson(Wishlist wishlist) {
    return {
      'id': wishlist.id,
      'product_id': wishlist.productId,
      'user_id': wishlist.userId,
      'createdAt': wishlist.createdAt,
      'updatedAt': wishlist.updatedAt
    };
  }
}
