import '../model/payment.dart';
import '../utils/http/http_client.dart';
class PaymentAPI {
  static dynamic getPayments(){
    return THttpHelper.get('payment/all');
  }

  static dynamic getPaymentByID(int id){
    return THttpHelper.get('payment/detail?id=$id');
  }

  static dynamic addPayment(Payment payment){
    return THttpHelper.post('payment/create', Payment.toJson(payment));
  }

  static dynamic updatePayment(Payment payment){
    return THttpHelper.put('payment/update', Payment.toJson(payment));
  }

  static dynamic deletePaymentByID(int id){
    return THttpHelper.delete('payment/delete?id=$id');
  }
}
