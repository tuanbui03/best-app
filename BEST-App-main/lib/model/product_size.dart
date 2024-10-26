class ProductSize {
  final int id;
  final int productId;
  final int sizeId;

  ProductSize(this.id, this.productId, this.sizeId);

  static Map<String, dynamic> toJson(ProductSize productSize) {
    return {
      'id': productSize.id,
      'product_id': productSize.productId,
      'size_id': productSize.sizeId,
    };
  }
}
