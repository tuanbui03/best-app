class ProductColor {
  final int id;
  final int productId;
  final int colorId;
  final String image;

  ProductColor(this.id, this.productId,this.colorId, this.image);

  static Map<String, dynamic> toJson(ProductColor colorImage) {
    return {'id': colorImage.id, 'product_id': colorImage.productId,'color_id': colorImage.colorId, 'image': colorImage.image};
  }
}
