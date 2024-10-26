class Product {
  final int id;
  final int brandId;
  final int categoryId;
  final int shopId;
  final String name;
  final int quantity;
  final double price;
  final String description;
  final String code;
  final int discount;
  final int sold;
  final String createdAt;
  final int status;

  Product(
      this.id,
      this.brandId,
      this.categoryId,
      this.shopId,
      this.name,
      this.quantity,
      this.price,
      this.description,
      this.code,
      this.discount,
      this.sold,
      this.createdAt,
      this.status);

  static Map<String, dynamic> toJson(Product product) {
    return {
      'id': product.id,
      'brand_id': product.brandId,
      'category_id': product.categoryId,
      'shop_id': product.shopId,
      'name': product.name,
      'quantity': product.quantity,
      'price': product.price,
      'description': product.description,
      'code': product.code,
      'discount': product.discount,
      'sold': product.sold,
      'created_at': product.createdAt,
      'status': product.status
    };
  }
}
