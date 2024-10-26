
class OrderDetail {
  int id;
  int orderId;
  int warehouseVoucherId;
  int productDetailId;
  int quantity;
  double price;

  OrderDetail(this.id, this.orderId, this.warehouseVoucherId, this.productDetailId, this.quantity, this.price);

  static Map<String, dynamic> toJson(OrderDetail orderDetail) {
    return {
      'id': orderDetail.id,
      'order_id': orderDetail.orderId,
      'warehouse_voucher_id': orderDetail.warehouseVoucherId,
      'product_detail_id': orderDetail.productDetailId,
      'quantity': orderDetail.quantity,
      'price': orderDetail.price,
    };
  }
}
