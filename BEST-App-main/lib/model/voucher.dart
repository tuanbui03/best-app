class Voucher {
  final int id;
  final String code;
  final int shopId;
  final int productId;
  final String dateStart;
  final String dateEnd;
  final int discountPercent;
  final String description;

  Voucher(this.id, this.code,this.shopId, this.productId ,this.dateStart, this.dateEnd,
      this.discountPercent, this.description);

  static Map<String, dynamic> toJson(Voucher voucher) {
    return {
      'id': voucher.id,
      'code': voucher.code,
      'shop_id': voucher.shopId,
      'product_id': voucher.productId,
      'date_start': voucher.dateStart,
      'date_end': voucher.dateEnd,
      'discount_percent': voucher.discountPercent,
      'description': voucher.description
    };
  }
}
