class ProductDetail {
   int id;
   int productSizeId;
   int productColorId;
  int quantity;

  ProductDetail(this.id, this.productSizeId, this.productColorId, this.quantity);

  static Map<String, dynamic> toJson(ProductDetail productDetail) {
    return {
      'id': productDetail.id,
      'product_size_id': productDetail.productSizeId,
      'product_color_id': productDetail.productColorId,
      'quantity': productDetail.quantity,
    };
  }
}
