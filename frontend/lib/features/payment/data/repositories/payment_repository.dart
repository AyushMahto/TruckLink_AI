import '../services/payment_service.dart';

class PaymentRepository {

  final PaymentService service = PaymentService();

  Future<bool> pay() {

    return service.makePayment();

  }

}