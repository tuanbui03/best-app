import 'package:best/utils/http/http_client.dart';
import '../model/warehouse_voucher.dart';

class WarehouseVoucherAPI {
  static dynamic getWarehouseVouchers() {
    return THttpHelper.get('warehouse_voucher/all');
  }

  static dynamic getWarehouseVoucherByID(int id) {
    return THttpHelper.get('warehouse_voucher/detail?id=$id');
  }
  static dynamic getWarehouseVoucherByUserID(int userID) {
    return THttpHelper.get('warehouse_voucher/byUser?userID=$userID');
  }
  static dynamic getWarehouseVoucherByUserIDAndProductID(int userID, int productID) {
    return THttpHelper.get('warehouse_voucher/byUser_Product?userID=$userID&productID=$productID');
  }

  static dynamic addWarehouseVoucher(WarehouseVoucher ob) {
    return THttpHelper.post('warehouse_voucher/create', WarehouseVoucher.toJson(ob));
  }

  static dynamic updateWarehouseVoucher(WarehouseVoucher ob) {
    return THttpHelper.put('warehouse_voucher/update', WarehouseVoucher.toJson(ob));
  }

  static dynamic deleteWarehouseVoucherByID(int id) {
    return THttpHelper.delete('warehouse_voucher/delete?id=$id');
  }
}
