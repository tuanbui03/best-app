class Order {
  late int id;
  late int userId;
  late int paymentId;
  late String address;
  late double total;
  late String createdAt;
  late String phone;
  late int status;

  Order(this.id, this.userId, this.paymentId, this.address, this.total,
      this.createdAt, this.phone,this.status);

  static Map<String, dynamic> toJson(Order order) {
    return {
      'id': order.id,
      'user_id': order.userId,
      'payment_id': order.paymentId,
      'address': order.address,
      'total': order.total,
      'created_at': order.createdAt,
      'phone': order.phone,
      'status': order.status,
    };
  }
}
