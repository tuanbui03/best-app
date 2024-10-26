class WarehouseVoucher {
  final int id;
  final int userId;
  final int voucherId;

  WarehouseVoucher(this.id, this.userId, this.voucherId);

  static Map<String, dynamic> toJson(WarehouseVoucher ob) {
    return {
      'id': ob.id,
      'user_id': ob.userId,
      'voucher_id': ob.voucherId
    };
  }
}
