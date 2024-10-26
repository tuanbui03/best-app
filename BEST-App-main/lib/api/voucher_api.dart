import '../model/voucher.dart';
import '../utils/http/http_client.dart';

class VoucherAPI {
  static dynamic getVouchers() {
    return THttpHelper.get('voucher/all');
  }

  static dynamic getVoucherByID(int id) {
    return THttpHelper.get('voucher/detail?id=$id');
  }

  static dynamic getVoucherByShopID(int shopID) {
    return THttpHelper.get('voucher/byShop?shopID=$shopID');
  }

  static dynamic addVoucher(Voucher voucher) {
    return THttpHelper.post('voucher/create', Voucher.toJson(voucher));
  }

  static dynamic updateVoucher(Voucher voucher) {
    return THttpHelper.put('voucher/update', Voucher.toJson(voucher));
  }

  static dynamic deleteVoucherByID(int id) {
    return THttpHelper.delete('voucher/delete?id=$id');
  }
}
